import random
import string
import time
import os

VALID_CODES_FILE = "valid_nitro_codes.txt"

def clear():
    os.system("cls" if os.name == "nt" else "clear")

def generate_code(length=16):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def save_valid_code(code):
    with open(VALID_CODES_FILE, "a") as f:
        f.write(f"https://discord.gift/{code}\n")

def print_banner():
    print("""
 ███▄    █  ██▓▄▄▄█████▓ ██▀███   ▒█████       ▄████ ▓█████  ███▄    █ 
 ██ ▀█   █ ▓██▒▓  ██▒ ▓▒▓██ ▒ ██▒▒██▒  ██▒    ██▒ ▀█▒▓█   ▀  ██ ▀█   █ 
▓██  ▀█ ██▒▒██▒▒ ▓██░ ▒░▓██ ░▄█ ▒▒██░  ██▒   ▒██░▄▄▄░▒███   ▓██  ▀█ ██▒
▓██▒  ▐▌██▒░██░░ ▓██▓ ░ ▒██▀▀█▄  ▒██   ██░   ░▓█  ██▓▒▓█  ▄ ▓██▒  ▐▌██▒
▒██░   ▓██░░██░  ▒██▒ ░ ░██▓ ▒██▒░ ████▓▒░   ░▒▓███▀▒░▒████▒▒██░   ▓██░
░ ▒░   ▒ ▒ ░▓    ▒ ░░   ░ ▒▓ ░▒▓░░ ▒░▒░▒░     ░▒   ▒ ░░ ▒░ ░░ ▒░   ▒ ▒ 
░ ░░   ░ ▒░ ▒ ░    ░      ░▒ ░ ▒░  ░ ▒ ▒░      ░   ░  ░ ░  ░░ ░░   ░ ▒░
   ░   ░ ░  ▒ ░  ░        ░░   ░ ░ ░ ░ ▒     ░ ░   ░    ░      ░   ░ ░ 
         ░  ░              ░         ░ ░           ░    ░  ░         ░ 
                                                                     
 Nitro generator v2 - by Spacy131
    """)

def print_info():
    print("""
    ──────────────────────────────────────────────
    [INFO] Version: v2
    [INFO] Creator: Spacy131 (spacy.ws)
    [INFO] Stop generation: ctrl + c
    [››››] Do not leave the software on for too long! Risk of computer self-destruction.
    ──────────────────────────────────────────────
    """)

def print_menu():
    print("""
    Choose an option:
    1. Info
    2. Start Generation
    3. Exit
    """)

def troll_result(valid, scanned):
    code = generate_code()
    if valid:
        print(f"[🎉] Valid Nitro code found! --> https://discord.gift/{code}")
        print("     Saved in the file 😏\n")
        save_valid_code(code)
    else:
        print(f"[❌] Invalid code: https://discord.gift/{code}")
    print(f"🔍 Codes scanned: {scanned}", end='\r')
    time.sleep(0.05 if not valid else 1.5)

def start_generator():
    clear()
    print_banner()
    print("💻 Starting the generator...\n")
    scanned = 0
    try:
        while True:
            scanned += 1
            valid = random.randint(1, 1000) == 1
            troll_result(valid, scanned)
    except KeyboardInterrupt:
        print("\n\n[👋] Generation stopped. See you next time!")

def main():
    while True:
        clear()
        print_banner()
        print_menu()
        choice = input("\n👉 Your choice (1/2/3): ").strip()

        if choice == "1":
            print_info()
            input("\nPress Enter to return to the menu.")
        elif choice == "2":
            start_generator()
        elif choice == "3":
            print("\n👋 See you later!")
            break
        else:
            print("❌ Invalid choice. Press Enter to try again.")
            input()

if __name__ == "__main__":
    main()
