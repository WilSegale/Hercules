source DontEdit.sh
clear
#get to the xfreerdp connection
ConnectXfreerdp(){

    FILE="connections.env"
    figlet -f slant "xfreerdp"

    # Check if file exists
    if [ -e "${FILE}" ]; then
        source connections.env
        xfreerdp /v:"${XFREERDP_IP}" /u:"${XFREERDP_USERNAME}" /p:"${XFREERDP_PASSWORD}"
    else
        sudo nmap -sS 192.168.1.1/24 -Pn -oN scan.txt --open
        echo
        read -p "Input IP: " ip
        read -p "Input username: " username
        read -s -p "Input password: " password
        echo
        read -p "Do you want to save this connection? (y/n) " save
        if [ $save == "y" ]; then
            echo "XFREERDP_IP${ip}" >> $FILE
            echo "XFREERDP_USERNAME=${username}" >> $FILE
            echo "XFREERDP_PASSWORD=${password}" >> $FILE
            
            echo "Loading xfreerdp server..."
            sleep 1
            xfreerdp /v:"${ip}" /u:"${username}" /p:"${password}"

        else
            # Put the
            echo
            echo "Loading xfreerdp server..."
            sleep 1
            xfreerdp /u:"${username}" /v:"${ip}" /p:"${password}"
            exit
        fi
    fi
}
ConnectXfreerdp