# Muat konfigurasi secara manual (non-autoconfig)
config.load_autoconfig(False)

# --------------------------------------
# URL dan Sesi (menggunakan konfigurasi searchengine dari blok kedua)
# --------------------------------------
c.url.start_pages = "https://search.realnephestate.xyz"
c.url.default_page = "about:blank"
c.auto_save.session = True

# --------------------------------------
# Adblock (aktifkan pemblokiran iklan & pelacak; menggunakan metode dan daftar filter dari blok kedua)
# --------------------------------------
c.content.blocking.method = "adblock"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    # "https://gitlab.com/curben/urlhaus-filter/-/raw/master/urlhaus-filter.txt",
    "https://pgl.yoyo.org/adservers/serverlist.php?showintro=0;hostformat=hosts",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://www.i-dont-care-about-cookies.eu/abp/",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
]

# --------------------------------------
# Tampilan (Font) -- menggunakan konfigurasi pertama
# --------------------------------------
c.fonts.default_family = "Tinos Nerd Font"
c.fonts.default_size = "11pt"

# Copy tanpa peringatan izin tambahan
c.content.javascript.clipboard = "access-paste"

# --------------------------------------
# Shortcut untuk Akses Cepat -- menggunakan konfigurasi pertama
# --------------------------------------
config.bind("gs", "open https://search.realnephestate.xyz")
config.bind("gc", "open --tab https://chat.openai.com")
config.bind("gd", "open --tab https://chat.deepseek.com")
config.bind("gy", "open --tab https://www.youtube.com")

# --------------------------------------
# Hapus shortcut default yang mengganggu
# --------------------------------------
config.unbind("<Ctrl-q>")
config.unbind("<Ctrl-w>")

# --------------------------------------
# Muat Tema Everblush -- menggunakan konfigurasi pertama
# --------------------------------------
config.source("everblush.py")

# --------------------------------------
# Konfigurasi tambahan dari blok kedua (tidak termasuk shortcut yang bertentangan)
# --------------------------------------
c.content.pdfjs = True  # Mengaktifkan penampil PDF bawaan
c.content.autoplay = False  # Mencegah pemutaran media secara otomatis

c.editor.command = ["vim", "{file}", "-c", "normal {line}G{column0}l"]
# Mengatur editor eksternal (di sini menggunakan st + vim) untuk mengedit teks

c.tabs.background = True  # Membuka tab di background
c.tabs.title.format_pinned = "{index} {audio}"
c.url.open_base_url = True  # Saat mengetik URL tanpa path, gunakan base URL

# --------------------------------------
# Format Judul Jendela
# --------------------------------------
c.window.title_format = "{perc}{current_title}{title_sep}nephestate browser"
