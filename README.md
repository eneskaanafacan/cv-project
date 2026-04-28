# Bilgisayarlı Görüye Giriş - Görüntü Sentezi ve Yapboz (Jigsaw) Üreteci

Bu depo, Ondokuz Mayıs Üniversitesi Bilgisayar Mühendisliği bölümü **Bilgisayarlı Görüye Giriş** dersi kapsamında geliştirdiğim MATLAB/Octave betiklerini içermektedir. 

Proje, dış kütüphane bağımlılığı olmadan tamamen matris matematiği ve vektörize işlemler üzerine kuruludur. Hem MATLAB hem de GNU Octave (Ubuntu/Linux) ortamlarında sorunsuz çalışmaktadır.

## 🚀 Projenin Özeti

Sistem iki ana aşamadan oluşur: Önce matematiksel denklemlerle "yoktan" bir görüntü var edilir, ardından bu görüntü bir algoritma ile parçalanıp karıştırılarak bir bulmacaya dönüştürülür.

### 1. `math_artist.m` - Matematiksel Görüntü Sentezi
Bu betik, hazır bir resim dosyası yüklemek yerine pikselleri trigonometrik ve üstel fonksiyonlarla oluşturur.
* **Vektörize Hesaplama:** Kartezyen ve kutupsal koordinatlar kullanılarak $1000 \times 1000$ çözünürlükte $R$, $G$ ve $B$ kanalları sentezlenir.
* **Topografik Analiz:** Her renk kanalının yoğunluk değerleri 3D yüzey (`surf`) grafikleri olarak görselleştirilerek matematiksel doku analiz edilir.
* **Normalize Çıktı:** Tüm kanallar $[0, 1]$ aralığına normalize edilerek `RGB_img` değişkeni olarak belleğe alınır.

### 2. `puzzle_generator.m` - Dinamik Yapboz Üreteci
`math_artist` tarafından üretilen veya sistemde hazır bulunan bir görüntüyü alarak işler.
* **Merkezi Kırpma (Center Crop):** Görüntüyü bozmadan merkezden kare formuna getirir.
* **Grid Bölümleme:** Görüntüyü $N \times N$ boyutunda (varsayılan $3 \times 3$) hücrelere ayırır.
* **Görsel Çerçeveleme:** Her bir yapboz parçasının kenarlarına `border_size` parametresi ile siyah sınırlar ekler.
* **Rastgele Karıştırma:** `randperm` algoritması ile parçaların yerlerini değiştirerek 3 farklı zorluk varyasyonu sunar.

## 🛠️ Kullanım Rehberi

Kodlar temel matris fonksiyonlarını kullandığı için ekstra bir toolbox kurulumu gerektirmez.

1. **Repoyu Klonlayın:**
   ```bash
   git clone https://github.com/eneskaanafacan/bilgisayarli-goruye-giris-proje.git
   cd bilgisayarli-goruye-giris-proje
   ```
2. **Çalıştırma Sırası:**
   * MATLAB veya Octave komut satırına `math_artist` yazarak sanatsal görüntüyü ve kanalları üretin.
   * Ardından `puzzle_generator` komutunu vererek bu görüntünün yapboz versiyonlarını oluşturun.

> **Not:** `puzzle_generator.m`, çalışma dizininde (workspace) `RGB_img` değişkenini bulamazsa otomatik olarak sistemdeki `peppers.png` dosyasını veya sentetik bir matrisi girdi olarak kabul eder.

---
