# Muat konfigurasi secara manual (non-autoconfig)
config.load_autoconfig(False)

# --------------------------------------
# URL dan Sesi
# --------------------------------------
c.url.start_pages = "https://www.google.com"
c.url.default_page = "https://www.google.com"
c.auto_save.session = True

# --------------------------------------
# Adblock (aktifkan pemblokiran iklan & pelacak)
# --------------------------------------
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/fanboy-social.txt",
    "https://pastebin.com/raw/sTGHyzTh",  # AdGuard: blok YouTube ads
    "https://pastebin.com/raw/8sTCR69y",  # h264ify: gunakan codec h264
]

# --------------------------------------
# Tampilan (Font)
# --------------------------------------
c.fonts.default_family = "Tinos Nerd Font"
c.fonts.default_size = "11pt"

# Copy tanpa peringatan izin tambahan
c.content.javascript.clipboard = "access-paste"

# --------------------------------------
# Shortcut untuk Akses Cepat
# --------------------------------------
config.bind("gs", "open https://www.google.com")
config.bind("gc", "open --tab https://chat.openai.com")
config.bind("gd", "open --tab https://chat.deepseek.com")
config.bind("gy", "open --tab https://www.youtube.com")

# --------------------------------------
# Hapus shortcut default yang mengganggu
# --------------------------------------
config.unbind("<Ctrl-q>")
config.unbind("<Ctrl-w>")

# --------------------------------------
# (Opsional) Mode Navigasi Vi-style
# --------------------------------------
# config.bind("h", "tab-prev")
# config.bind("l", "tab-next")

# --------------------------------------
# Muat Tema Everblush
# --------------------------------------
config.source("everblush.py")
