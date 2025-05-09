import cv2, numpy as np, matplotlib.pyplot as plt
# Make sure to install OpenCV and Matplotlib if not already installed
# pip install opencv-python matplotlib


img = cv2.imread(r'1. Main Code\test_filter_img.png', 0)  # Put full path if needed
if img is None: exit("Image not found.")
img = cv2.resize(img, (256, 256))

f = np.fft.fft2(img)
fshift = np.fft.fftshift(f)
mag = 20 * np.log(np.abs(fshift) + 1)

def ideal(shape, r, t):  # t: 'low' or 'high'
    u, v = np.indices(shape)
    d = np.sqrt((u - shape[0]//2)**2 + (v - shape[1]//2)**2)
    return (d < r) if t == 'low' else (d > r)

def gaussian(shape, r, t):
    u, v = np.indices(shape)
    d2 = (u - shape[0]//2)**2 + (v - shape[1]//2)**2
    g = np.exp(-d2 / (2 * r**2))
    return g if t == 'low' else 1 - g

def notch(shape, centers, r):
    u, v = np.indices(shape)
    mask = np.ones(shape)
    for cx, cy in centers:
        d1 = np.sqrt((u - cx)**2 + (v - cy)**2)
        d2 = np.sqrt((u - (shape[0]-cx))**2 + (v - (shape[1]-cy))**2)
        mask *= (d1 > r) * (d2 > r)
    return mask

def apply(mask): return np.abs(np.fft.ifft2(np.fft.ifftshift(fshift * mask)))

r = 30  # radius
results = [
    ('Original', img),
    ('Spectrum', mag),
    ('Ideal LP', apply(ideal(img.shape, r, 'low'))),
    ('Ideal HP', apply(ideal(img.shape, r, 'high'))),
    ('Gaussian LP', apply(gaussian(img.shape, r, 'low'))),
    ('Gaussian HP', apply(gaussian(img.shape, r, 'high'))),
    ('Notch', apply(notch(img.shape, [(138,128)], 10))),
]

plt.figure(figsize=(12, 9))
for i, (t, im) in enumerate(results):
    plt.subplot(3, 3, i+1)
    plt.imshow(im, cmap='gray')
    plt.title(t), plt.axis('off')
plt.tight_layout(), plt.show()

"""_summary_
### Task 4: Analysis

**Comparison with Original Image:**

* **Ideal Low-pass Filter**:

  * Smooths the image by removing high-frequency components (edges, noise).
  * Retains low-frequency information (background, overall shape).
  * Results in a **blurred image**.

* **Ideal High-pass Filter**:

  * Preserves high-frequency details (edges) and removes smooth background.
  * Enhances sharp transitions but removes shading and low-detail areas.
  * Output appears **edge-like** and may look dark or noisy.

* **Gaussian Low-pass Filter**:

  * Similar to ideal LPF but smoother in transition.
  * **Less ringing artifacts** than ideal LPF.
  * More natural blur due to soft decay in frequency response.

* **Gaussian High-pass Filter**:

  * Like ideal HPF, but smoother result.
  * Retains edges without harsh discontinuities.
  * **Cleaner edge enhancement** than ideal HPF.

* **Notch Filter**:

  * Removes **specific frequency components** (e.g., periodic noise).
  * Effective in removing repetitive noise patterns (like stripes or dots).
  * Image retains detail except at the filtered frequency band.

---

**Effect of Changing Radius (10, 30, 60, 160):**

| Radius | Low-pass Filters             | High-pass Filters                      |
| ------ | ---------------------------- | -------------------------------------- |
| 10     | Strong blur, loses detail    | Strong edges, noisy output             |
| 30     | Moderate blur                | Clean edges, less noise                |
| 60     | Slight blur, better detail   | Emphasizes finer structures            |
| 160    | Almost original, little blur | Minimal enhancement (most info passed) |

* **Smaller radius**:

  * LPF → **More aggressive blur**
  * HPF → **Keeps only fine edges**, suppresses most of the image
* **Larger radius**:

  * LPF → **Passes more detail**, closer to original
  * HPF → **Acts weaker**, passes most of the image
"""