def quickSort(arr, fun):
    """
    快速排序
    :param arr: 待排序数组
    :param fun: 排序函数
    :return:
    """
    qsort(arr, 0, len(arr) - 1, fun)
    print(arr)



def qsort(arr, low, high, fun):
    if low < high:
        # 将数组分为两个部分
        p = partition(arr, low, high, fun)
        
        # 递归排序左子数组
        qsort(arr, low, p - 1, fun)
        
        # 递归排序右子数组
        qsort(arr, p + 1, high, fun)



def partition(arr, low, high, fun):
    p = arr[low]
    while low < high:
        
        # 交换比枢轴小的到左端
        while low < high and not fun(arr[high], p):
            high = high - 1
        arr[low] = arr[high]

        # 交换比枢轴大的记录到右端
        while low < high and fun(arr[low], p):
            low = low + 1
        arr[high] = arr[low]

        # 扫描完成，枢轴到位
        arr[low] = p
    return low


quickSort(["1", "22", "333", "4444", "55555"], lambda x, y: len(x) > len(y))