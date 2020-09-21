# !/bin/bash
# !/bin/sh

echo "Дата: $(date +"%m-%d-%Y");"
echo "Имя учётной записи: $(whoami);"
echo "Доменное имя ПК: $(hostname);"
#echo "$(lscpu) "
echo ""

echo "Процессор:"
echo "  Модель - $(cat /proc/cpuinfo | grep 'model name' | awk '{print($6)}' | uniq)"
echo "  Архитектура - $(lscpu | grep 'Architecture' | awk '{print($2)}')"
echo "  Тактовая частота - $(lscpu | grep 'CPU MHz' | awk '{print($3)}') МГц"
echo "  Количество ядер - $(lscpu | grep 'Core(s) per socket:' | awk '{print($4)}')"
echo "  Количество потоков на одно ядро - $(lscpu | grep 'Thread(s) per core' | awk '{print($4)}')"
echo ""

echo "Оперативная память:"
echo "  Всего    - $(cat /proc/meminfo | grep MemTotal | awk '{print($2)}') kB"
echo "  Доступно - $(cat /proc/meminfo | grep MemFree | awk '{print($2)}') kB"
echo ""

echo "Жёсткий диск:"
echo "  Всего    - $(df -h | grep G: | awk '{print($2)}')"
echo "  Доступно - $(df -h | grep G: | awk '{print($4)}')"
# echo "  Смонтировано в корневую директорию / - $(df -h | grep -w '/' | awk '{print($1)}')"
echo "  SWAP всего    - $(free -h | grep 'Swap:' | awk '{print($2)}')"
echo "  SWAP доступно - $(free -h | grep 'Swap:' | awk '{print($4)}')"
echo ""

echo "Сетевые интерфейсы:" 
echo "  Количество сетевых интерфейсов - $(ls -l /sys/class/net | grep "d" |  wc | awk '{print($1)}')"

count_interfaces=0
interfaces_file=$(ls /sys/class/net)
# echo -n -e "\E[s"
echo -e -n "      Имйа\n\E[s№   сетевого\n   интерфейса"
echo -e -n "\E[u\E[15CMAC адрес"
echo -e -n "\E[u\E[37CIP адрес"
echo -e -n "\E[u\E[54CСкорость"
echo ""
for var in $interfaces_file
    do
    count_interfaces=$((count_interfaces+1))
    # Speed=$(sudo ethtool $var | grep Speed | awk '{print $2}')
    ip=$(ifconfig $var | grep -w inet  | awk '{print $2}')
    mac=$(ifconfig $var | grep -w ether | awk '{print $2}')

    echo -n -e "\E[s"
    echo -n "$count_interfaces) "
    echo -n "$var "
    # echo -n -e "\E[u"
    echo -n -e "\E[u\E[15C$(ifconfig $var | grep -w ether | awk '{print $2}')"
    echo -e -n "\E[u\E[37C$(ifconfig $var | grep -w inet  | awk '{print $2}')"
    echo -e "\E[u\E[54C"

    i=$((i+1))

done

# count_interfaces=0



# count_interfaces=0
# interfaces_file=$(ls /sys/class/net)
# for var in $interfaces_file
# do
# count_interfaces=$((count_interfaces+1))
# #echo "  $count_interfaces $var $(ifconfig -a | grep ether | gawk '{print $2}') $(ifconfig -a | grep -w inet | gawk '{print $2}') $(sudo ethtool $var |grep Speed)"
# done

# echo " $(ifconfig -a | grep -w inet | gawk '{print $2}') "
# #echo "$(ifconfig -a | grep mtu | gawk '{print $1}') $(ifconfig -a | grep ether | gawk '{print $2}') $(ifconfig -a | grep -w inet | gawk '{print $2}') "

# # sudo ethtool enp8s0 |grep Speed

# # echo "$(ifconfig -a | grep mtu | gawk '{print $1}') $(ifconfig -a | grep ether | gawk '{print $2}') $(ifconfig -a | grep -w inet | gawk '{print $2}') $(ethtool enp8s0 |grep Speed)"
