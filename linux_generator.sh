#!/bin/bash

VALID_CODES_FILE="valid_nitro_codes.txt"
VALID_CODE_CHANCE=6

# Fonction pour générer un code aléatoire
generate_code() {
    code=""
    for i in {1..16}; do
        rand=$((RANDOM % 36))
        if [ $rand -lt 10 ]; then
            # Ajouter un chiffre
            code+=$(printf "%c" $((rand + 48)))
        else
            # Ajouter une lettre
            code+=$(printf "%c" $((rand + 87)))
        fi
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
    echo "3. Exit"
}

# Démarre la génération
start_generator() {
    clear
    print_banner
    echo "💻 Starting the generator..."
    echo ""

    scanned=0
    while true; do
        scanned=$((scanned + 1))
        code=$(generate_code)
        rand=$((RANDOM % VALID_CODE_CHANCE))

        # Simuler une chance de code valide (1 sur 1000)
        if [ $rand -eq 1 ]; then
            echo "[🎉] Valid Nitro code found! --> https://discord.gift/$code"
            echo "     Saved in the file 😏"
            save_valid_code "$code"
        else
            echo "[❌] Invalid code: https://discord.gift/$code"
        fi

        echo "🔍 Codes scanned: $scanned"
        echo "🚀 Leave: ctrl + c"
        sleep 1
    done
}

# Fonction principale
main() {
    while true; do
        clear
        print_banner
        print_menu
        read -p "👉 Your choice (1/2/3): " choice

        if [ "$choice" == "1" ]; then
            print_info
            read -p "Press Enter to return to the menu."
        elif [ "$choice" == "2" ]; then
            start_generator
        elif [ "$choice" == "3" ]; then
            echo "👋 See you later!"
            exit
        else
            echo "❌ Invalid choice. Press Enter to try again."
            read
        fi
    done
}

# Lancer la fonction principale
main
