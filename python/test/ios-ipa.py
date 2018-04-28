#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
Xcode工程自动打包
'''
__author__ = '付国良'

import os
import getpass
import smtplib
import sys
import hashlib
import optparse
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.header import Header
from datetime import date, time, datetime, timedelta
from Print import wn_print
from Command import Command
import re

# 邮件
emailFrom = '444306979@qq.com'
emailTo = '444306979@qq.com'

# 工程配置
mainPath = '/Users/fuguoliang/company/玩哪儿/wannarTwo'
projectName = 'wannarTwo'
targetName = 'WannarTravel'
certificateName = 'iPhone Developer'


# 查找类型文件
def scanTypeFiles(directory, postfix='.xcodeproj'):
    files_list = []
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if filename.endswith(postfix):
                files_list.append(os.path.join(root, filename))
        for special_file in dirs:
            if special_file.endswith(postfix):
                files_list.append(os.path.join(root, special_file))
    return files_list

# 查找文件
def scanFiles(directory, filenames=['WNMacroAPI.h']):
    files_list = []
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if filename in filenames:
                files_list.append(os.path.join(root, filename))
        for special_file in dirs:
            if special_file in filenames:
                files_list.append(os.path.join(root, filename))
    return files_list


# 当前文件路径
def curPath():
    return os.path.realpath(__file__)


# 当前文件所处文件夹路径
def curDir():
    return os.path.dirname(os.path.realpath(__file__))


# 判断文件夹是否存在
def isFinderExists():
    return os.path.exists(mainPath)


# 判断是否是workspace
def isWorkSpace():
    if os.path.exists("%s/%s.xcworkspace" % (mainPath, projectName)):
        return True
    else:
        return False


# 修改debugModel
def modifyDebugModel():
    macroPaths = scanFiles(mainPath, ['WNMacroAPI.h'])
    macroPath = ''
    if len(macroPaths) > 0:
        macroPath = macroPaths[0]
    l = 0
    if os.path.exists(macroPath) and os.path.isfile(macroPath):
        with open(macroPath, 'r') as f:
            for line in f.readlines():
                l += 1
                if line == "#define kDebug\n":
                    break
    sed = "sed -i '' '%ss*#define kDebug*//#define kDebug*' %s" % (l, macroPath)
    wn_print(sed)
    os.system(sed)

# clean工程
def cleanPro():
    if isWorkSpace():
        os.system('cd %s;xcodebuild -workspace %s.xcworkspace -scheme %s clean' % (mainPath, projectName, targetName))
    else:
        os.system('cd %s;xcodebuild -target %s clean' % (mainPath, targetName))
    return


# 编译获取.app文件和dsym
def buildApp():
    global isWorkSpace
    files_list = scanTypeFiles(mainPath, postfix=".xcodeproj")
    temp = -1
    for k in range(len(files_list)):
        if files_list[k] == mainPath + "/" + projectName + ".xcodeproj":
            temp = k
    if temp >= 0:
        files_list.pop(temp)
    for target in files_list:
        target = target.replace(".xcodeproj","")
        tmpList = target.split('/')
        name = tmpList[len(tmpList)-1]
        path = target.replace(name,"")
        path = path[0:len(path)-1]
        os.system("cd %s;xcodebuild -target %s CODE_SIGN_IDENTITY='%s'"%(path, name, certificateName))
    if isWorkSpace:
        os.system("cd %s;xcodebuild -workspace %s.xcworkspace -scheme %s CODE_SIGN_IDENTITY='%s' -derivedDataPath build/"%(mainPath, projectName, targetName, certificateName))
    else:
        wn_print("【NoWorkSpace】cd %s;xcodebuild -target %s CODE_SIGN_IDENTITY='%s'"%(mainPath, targetName, certificateName))
        os.system()
    return

# 创建ipa文件
def creatIPA():
    os.system("cd %s;rm -r -f %s.ipa" % (mainPath, targetName))
    os.system("cd %s;xcrun -sdk iphoneos PackageApplication -v %s/build/Build/Products/Debug-iphoneos/%s.app -o %s/%s.ipa CODE_SIGN_IDENTITY='%s'" % (
            mainPath, mainPath, targetName, mainPath, targetName, certificateName))
    return



# 发邮件给测试人员
def sendEmail(text):
    msg = MIMEText(text, 'plain', 'utf-8')
    msg['From'] = Header('付国良', 'utf-8')
    msg['To'] = Header('测试', 'utf-8')
    msg['Subject'] = Header('新的测试包已经上传', 'utf-8')
    try:
        s = smtplib.SMTP_SSL("smtp.qq.com", 465)
        s.login(emailFrom, 'enzvwbfzczskcaji')
        s.sendmail(emailFrom, emailTo, msg.as_string())
        s.quit()
        print('邮件发送成功...')
    except smtplib.SMTPException as e:
        print('Error: 无法发送邮件(%s)' % e)


def main():
    # modifyDebugModel()
    buildApp()
    creatIPA()
    # sendEmail('新的测试包已上传，地址:')

main()

