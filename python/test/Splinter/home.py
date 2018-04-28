#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
测试网站基本功能
'''
__author__ = '付国良'


from selenium import webdriver
import time
import os


def save(case, isPass):
    '''
    保存测试case
    '''
    with open('web_test_result.csv', 'a') as f:
        result = isPass and '√' or '✘'
        f.writelines(case + ',' + result + os.linesep)


def loginEmail(t):
    '''
    邮箱登录测试
    '''
    try:
        bwr = webdriver.Chrome()
        url = 'https://www.wannar.com/signin.php'
        bwr.get(url)
        bwr.find_element_by_name('email').send_keys('444306979@qq.com')
        bwr.find_element_by_name('pwd').send_keys('boolbool')
        bwr.find_element_by_name('login').click()
        time.sleep(10)
        if '测试用自己人' in bwr.find_element_by_class_name('welcome').text:
            save(t, True)
        else:
            save(t, False)
    except:
        save(t, False)
    finally:
        bwr.quit()


def loginQQ(t):
    '''
    QQ登录测试
    '''
    try:
        bwr = webdriver.Chrome()
        bwr.get('https://www.wannar.com/signin.php')
        bwr.find_elements_by_class_name('third-party-btn')[0].click()
        time.sleep(5)

        # 切入iframe
        bwr.switch_to.frame(bwr.find_element_by_id('ptlogin_iframe'))
        time.sleep(1)

        # 点击账号与密码登录
        bwr.find_element_by_id('switcher_plogin').click()
        time.sleep(1)

        # 输入账号
        bwr.find_element_by_id('u').send_keys('444306979')
        time.sleep(1)

        # 输入密码
        bwr.find_element_by_id('p').send_keys('Fgl901128.')
        time.sleep(1)

        # 点击登录
        bwr.find_element_by_id('login_button').click()
        time.sleep(1)

        # 切出
        bwr.switch_to.default_content()
        time.sleep(10)
        if '测试用自己人' in bwr.find_element_by_class_name('welcome').text:
            save(t, True)
        else:
            save(t, False)

    except BaseException as e:
        save(t, False)
    finally:
        bwr.quit()
        pass


def loginSina(t):
    '''
    新浪微博登录测试
    '''
    try:
        bwr = webdriver.Chrome()
        bwr.get('https://www.wannar.com/signin.php')
        bwr.find_elements_by_class_name('third-party-btn')[1].click()
        time.sleep(1)

        # 账号
        bwr.find_element_by_id('userId').send_keys('444306979@qq.com')

        # 密码
        bwr.find_element_by_id('passwd').send_keys('Fgl901128.')

        # 登录点击
        btn = bwr.find_elements_by_xpath("//*[@node-type='submit']")[0]
        time.sleep(1)
        btn.click()

        time.sleep(15)
        if '测试用自己人' in bwr.find_element_by_class_name('welcome').text:
            save(t, True)
        else:
            save(t, False)
    except BaseException as e:
        print(e)
        save(t, False)
    finally:
        bwr.quit()


def register(t):
    '''
    用户注册
    '''
    def getLineStr(index):
        return str(index) + ',' + 'python' + str(index) + '@wannar.com,' + 'test' + str(index) + os.linesep


    def saveEmailAndName():
        with open('wannar_user.txt', 'a+') as f:
            l = f.readlines()
            if len(l) == 0:
                index = 0
            else:
                index = int(f.readlines()[-1].split(',')[0]) + 1
            f.write(getLineStr(index))


    def getEmailAndName():
        saveEmailAndName()
        with open('wannar_user.txt', 'r') as f:
            l = f.readlines()
            return l[-1].replace(os.linesep, '').split(',')[1:]

    try:
        bwr = webdriver.Chrome()
        bwr.get('https://www.wannar.com/signin.php')
        bwr.find_element_by_css_selector('.user-reg.not-for-pwd-forgotten').click()
        time.sleep(10)

        l = getEmailAndName()
        email = l[0]
        name = l[1]
        print(email)
        print(name)
        bwr.find_element_by_id('email').send_keys(email)
        bwr.find_element_by_id('name').send_keys(name)
        bwr.find_element_by_id('pwd1').send_keys('wannartest')
        bwr.find_element_by_id('pwd2').send_keys('wannartest')
        regBtn = bwr.find_element_by_id('submit')
        time.sleep(1)
        regBtn.click()
        time.sleep(10)
        if name in bwr.find_element_by_class_name('welcome').text:
            save(t, True)
        else:
            save(t, False)

    except BaseException as e:
        print(e)
        save(t, False)
    finally:
        bwr.quit()


if __name__ == '__main__':
    # loginEmail('邮箱登录')
    loginQQ('QQ登录')
    loginSina('Sina登录')
    # register('新用户注册')
