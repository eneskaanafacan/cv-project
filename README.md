# Bilgisayarlı Görüye Giriş - Görüntü Sentezi ve Yapboz (Jigsaw) Üreteci

 Bu repo, Ondokuz Mayıs Üniversitesi Bilgisayar Mühendisliği bölümünde aldığım **Bilgisayarlı Görüye Giriş** dersi proje ödevi için hazırladığım MATLAB/Octave betiklerini içermektedir. 

Projeyi dışarıdan hazır kütüphanelere (OpenCV vb.) bağımlı kalmadan, işin tamamen matris matematiğine ve temel algoritmik mantığına inerek geliştirdim. Hem MATLAB hem de GNU Octave (özellikle Ubuntu/Linux ortamlarında) ile tam uyumlu çalışacak şekilde vektörize edilmiştir.

---

## 🚀 Projenin İçeriği

Proje genel olarak iki farklı betikten (script) oluşuyor. İstenen görevler doğrultusunda şu iki işlemi gerçekleştiriyor:

### 1. `math_artist.m` - Matematiksel Fonksiyonlarla RGB Sentezi
Hazır bir resim kullanmak, `rand`, `ones` veya `zeros` gibi basit fonksiyonlarla matris doldurmak yerine; tamamen trigonometrik (`sin`, `cos`), üstel (`exp`) ve kutupsal koordinat ($R$, $Theta$) denklemleri kullanarak yapay bir RGB görüntü sentezler. 
* Döngü (for/while) kullanılmadan, tüm pikseller kartezyen matrisler üzerinden vektörize olarak hesaplanır.
* Oluşturulan her bir renk kanalının (Kırmızı, Yeşil, Mavi) piksel yoğunlukları, 3 boyutlu uzayda topografik yüzey (surf) olarak çizdirilir.

### 2. `puzzle_generator.m` - Jigsaw (Bulmaca) Oluşturucu
Bir görüntüyü matris uzayında alt bloklara bölüp rastgele karıştırarak yapboz varyasyonları elde eder.
* **Merkezi Kırpma (Center Crop):** Girdi görüntüsünün en-boy oranına bakarak tam merkezden kusursuz bir kare kırpar.
* **Bölütleme (Slicing):** Kare matrisi `mat2cell` ile NxN (örneğin 4x4 = 16) eşit hücreye böler ve her parçanın etrafına yapboz hissi vermesi için siyah çerçeveler çizer.
* **Rastgele Karma (Shuffling):** Elde edilen parçaları `randperm` ile istatistiksel olarak karıştırır ve 3 farklı varyasyon oluşturur.

---

## 🛠️ Kurulum ve Çalıştırma

Kodlar herhangi bir ekstra "Image Processing Toolbox" gerektirmez, temel matris fonksiyonlarıyla yazılmıştır.

1. Repoyu bilgisayarınıza klonlayın:
   ```bash
   git clone https://github.com/kullaniciadiniz/bilgisayarli-goruye-giris-proje.git
   cd bilgisayarli-goruye-giris-proje
   ```
2. MATLAB veya GNU Octave'ı açın.
3. Çalışma dizini olarak bu klasörü seçin.
4. Sırasıyla betikleri çalıştırın:
   * Önce `math_artist` yazıp Enter'a basın (Yapay resmi üretir).
   * Ardından `puzzle_generator` yazıp Enter'a basın (Üretilen bu resmi alıp yapboza çevirir).

*Not: Eğer `math_artist` çalıştırılmadan `puzzle_generator` çalıştırılırsa, kod hata vermez; kendi içinde sentetik bir test matrisi veya `peppers.png` kullanarak çalışmaya devam eder.*

---