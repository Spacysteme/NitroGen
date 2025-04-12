#!/bin/bash

VALID_CODES_FILE="valid_nitro_codes.txt"
VALID_CODE_CHANCE=550
SLEEP_DURATION=0.5

CHARSET=('0' '1' '2' '3' '4' '5' '6' '7' '8' '9'
         'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'
         'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z')

# Fonction pour générer un code aléatoire
generate_code() {
    code=""
    for i in {1..16}; do
        rand=$((RANDOM % ${#CHARSET[@]}))
        code+="${CHARSET[$rand]}"
    done
    echo "$code"
}

# Fonction pour sauvegarder un code valide
save_valid_code() {
    echo "https://discord.gift/$1" >> "$VALID_CODES_FILE"
}

# Affichage du banner
print_banner() {
    echo " ███▄    █  ██▓▄▄▄█████▓ ██▀███   ▒█████       ▄████ ▓█████  ███▄    █"
    echo " ██ ▀█   █ ▓██▒▓  ██▒ ▓▒▓██ ▒ ██▒▒██▒  ██▒    ██▒ ▀█▒▓█   ▀  ██ ▀█   █"
    echo "▓██  ▀█ ██▒▒██▒▒ ▓██░ ▒░▓██ ░▄█ ▒▒██░  ██▒   ▒██░▄▄▄░▒███   ▓██  ▀█ ██▒"
    echo "▓██▒  ▐▌██▒░██░░ ▓██▓ ░ ▒██▀▀█▄  ▒██   ██░   ░▓█  ██▓▒▓█  ▄ ▓██▒  ▐▌██▒"
    echo "▒██░   ▓██░░██░  ▒██▒ ░ ░██▓ ▒██▒░ ████▓▒░   ░▒▓███▀▒░▒████▒▒██░   ▓██░"
    echo "░ ▒░   ▒ ▒ ░▓    ▒ ░░   ░ ▒▓ ░▒▓░░ ▒░▒░▒░     ░▒   ▒ ░░ ▒░ ░░ ▒░   ▒ ▒"
    echo "░ ░░   ░ ▒░ ▒ ░    ░      ░▒ ░ ▒░  ░ ▒ ▒░      ░   ░  ░ ░  ░░ ░░   ░ ▒░"
    echo "   ░   ░ ░  ▒ ░  ░        ░░   ░ ░ ░ ░ ▒     ░ ░   ░    ░      ░   ░ ░"
    echo "         ░  ░              ░         ░ ░           ░    ░  ░         ░"
    echo ""
    echo " Nitro generator v2 - by Spacy131"
}

# Affichage des infos
print_info() {
    echo "──────────────────────────────────────────────"
    echo "[INFO] Version: v2"
    echo "[INFO] Creator: Spacy131 (spacy.ws)"
    echo "[INFO] Stop generation: ctrl + c"
    echo "[››››] Do not leave the software on for too long! Risk of computer self-destruction."
    echo "──────────────────────────────────────────────"
}

# Affichage du menu
print_menu() {
    echo "Choose an option:"
    echo "1. Info"
    echo "2. Start Generation"
    echo "3. Change generation speed"
    echo "4. Exit"
}

# Démarre la génération
start_generator() {
    clear
    print_banner
    echo "💻 Starting the generator (1 code every $SLEEP_DURATION sec)..."
    echo ""

    scanned=0
    while true; do
        scanned=$((scanned + 1))
        code=$(generate_code)
        rand=$((RANDOM % VALID_CODE_CHANCE))

        if [ $rand -eq 1 ]; then
            echo "[🎉] Valid Nitro code found! --> https://discord.gift/$code"
            echo "     Saved in the file 😏"
            save_valid_code "$code"
            echo "⏳ Cooldown for 1.5 seconds..."
            sleep 1.5  # Cooldown de 1.5 secondes après un code valide
        else
            echo "[❌] Invalid code: https://discord.gift/$code"
        fi

        echo "🔍 Codes scanned: $scanned"
        echo "🚀 Leave: ctrl + c"
        sleep $SLEEP_DURATION
    done
}

# Fonction pour ajuster la vitesse
change_speed() {
    while true; do
        read -p "⏱️  Enter new delay between generations (min: 0.001, e.g. 0.05 = 20/sec): " new_delay
        if [[ "$new_delay" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
            if (( $(echo "$new_delay >= 0.001" | bc -l) )); then
                SLEEP_DURATION=$new_delay
                echo "✅ Speed updated! Now generating every $SLEEP_DURATION sec"
                sleep 1
                break
            else
                echo "❌ Please enter a delay of at least 0.001 seconds."
            fi
        else
            echo "❌ Invalid input. Please enter a valid number (e.g., 0.05)."
        fi
    done
}

# Fonction principale
main() {
    while true; do
        clear
        print_banner
        print_menu
        read -p "👉 Your choice (1/2/3/4): " choice

        case $choice in
            1)
                print_info
                read -p "Press Enter to return to the menu."
                ;;
            2)
                start_generator
                ;;
            3)
                change_speed
                ;;
            4)
                echo "👋 See you later!"
                exit
                ;;
            *)
                echo "❌ Invalid choice. Press Enter to try again."
                read
                ;;
        esac
    done
}

# Lancer la fonction principale
main
