mini = '00000000000000000'
maxi = '11111111111111111'

x = "0.0000e+000"


def ADC(num):
    n1 = porcent(num)
    n2 = toAdc(n1)
    return n2


def porcent(num):
    if num < 0:
        return 0
    if num > 5:
        return 100
    else:
        op = 100/5*num
        return round(op)


def toAdc(num):
    op = num*131071/100
    result = bin(round(op))[2:]

    return result.zfill(17)


def writeFile(data):
    vFile = open(f'salida2adc.txt', 'a')
    vFile.write(data+"\n")
    vFile.close()


vFile = open(f'salida2adc.txt', 'w')
vFile.truncate()
vFile.close()


with open('salida2.txt', 'r') as f:
    for linea in f:
        # print(linea)
        x = float(linea)
        result = ADC(x)

        writeFile(result)
