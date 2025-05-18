# Speech Recognition on FPGA

## Full Process Flow: What Happens Once We Receive the Audio File?
Once you have a pre-recorded audio file, you need to process it in multiple steps before running it on the FPGA (Cora Z7) for speech recognition.

### Step-by-Step Breakdown of the Entire Process
**Goal:** Convert the given audio file into a format that can be processed on FPGA for keyword recognition.

### 1. Convert Audio File to 16-bit PCM Format
**Why?**
- FPGA does not support MP3, WAV, or compressed audio.
- It can only process raw PCM (Pulse Code Modulation) data.

**Steps to Convert:**
1. Receive the audio file (speech.wav or speech.mp3).
2. Convert it into 16-bit PCM format with a 16kHz sample rate.
3. Save it as a raw .pcm file.

 Now, we have `speech.pcm`, which can be processed by the FPGA.

### 2. Convert PCM Data for FPGA BRAM Storage
**Why?**
- FPGA does not read files like a computer.
- We must pre-load the PCM data into Block RAM (BRAM).
- BRAM requires a Verilog-compatible initialization file (.coe).

 Now, `audio.coe` is ready to be loaded into FPGA BRAM.

### 3. Load Audio Data into FPGA BRAM
**Why?**
- FPGA needs a Verilog module to store the PCM data in BRAM.
- The PCM samples will be read one-by-one for processing.

 Now, FPGA can access the PCM data stored in BRAM.

### 4. Perform Feature Extraction (MFCC) on FPGA
**Why?**
- Neural networks cannot process raw PCM.
- We need MFCC (Mel-Frequency Cepstral Coefficients), a standard feature extraction method in speech recognition.

**Steps in Feature Extraction:**
1. Apply FFT (Fast Fourier Transform) → Convert PCM to frequency domain.
2. Apply Mel Filterbank → Convert to a human-perceived scale.
3. Extract MFCCs → Reduce the data to 13 features per frame.

 Now, the extracted MFCC features are ready for classification.

### 5. Load Pre-Trained Model Weights into FPGA
**Why?**
- The neural network must use pre-trained weights.
- The weights are stored as `.txt` files and need to be converted for FPGA.

 Now, FPGA can use `weights.coe` for neural network inference.

### 6. Run Neural Network Inference on FPGA

### 7. Display the Recognized Keyword
**Why?**
- The classified keyword needs to be displayed.

 Now, the FPGA displays the classified keyword via UART.

## Summary of Entire Process
Pre-recorded audio → PCM → BRAM → FFT → MFCC → Neural Network → Display Result

## What Files Need to be Saved in FPGA?
Once all the preprocessing is done, only the `.coe` files and the Verilog (`.v`) files are needed on the FPGA.

### 1. Files Needed on the FPGA
| File Type | Purpose | Required on FPGA? |
|-----------|---------|------------------|
| Verilog Files (.v) | Implement logic for FFT, MFCC, Neural Network, and UART |  Yes |
| Coefficients File (.coe) | Initialize BRAM with audio samples and neural network weights |  Yes |
| PCM File (.pcm) | Raw 16-bit PCM audio file |  No (Converted to .coe) |
| Text Weight Files (weights.txt) | Pre-trained neural network weights |  No (Converted to .coe) |
| Converted Weight Files (weights.coe) | BRAM initialization for neural network |  Yes |

 Only `.coe` files and Verilog (`.v`) files are stored and programmed into the FPGA.
 `weights.txt` and `speech.pcm` are used on the PC to generate `.coe`, but they are NOT needed on FPGA.

### 2. Complete List of Required Files on FPGA
#### 🔹 Verilog (.v) Files (Logic Modules)
- `audio_bram.v` → Stores pre-recorded PCM audio in BRAM.
- `fft.v` → Computes Fast Fourier Transform (FFT).
- `mel_filterbank.v` → Extracts MFCC features from FFT output.
- `dense_layer.v` → Runs neural network inference using pre-trained weights.
- `softmax.v` → Finds highest probability keyword.
- `uart_display.v` → Displays classified keyword via UART.
- `top_module.v` → Integrates all the modules into one complete system.

#### 🔹 .coe Files (BRAM Initialization)
- `audio.coe` → Stores pre-recorded PCM data in BRAM.
- `fc1_weights.coe` → Stores Dense Layer 1 weights.
- `fc1_biases.coe` → Stores Dense Layer 1 biases.
- `fc2_weights.coe` → Stores Dense Layer 2 weights.
- `fc2_biases.coe` → Stores Dense Layer 2 biases.

 These `.coe` files will be used inside Vivado’s "Block Memory Generator" to initialize BRAM.

### 3. Steps to Load .coe Files into FPGA
#### Step 1: Open Vivado & Create a Block RAM Module
- Open Vivado and create a new project.
- Go to IP Catalog → Search for "Block Memory Generator".
- Select Simple Dual Port RAM (Write First).

#### Step 2: Load .coe Files into BRAM
- Click on "Load Initialization File" in the BRAM properties.
- Select `audio.coe` to load the pre-recorded PCM audio.
- Select `fc1_weights.coe`, `fc1_biases.coe`, etc. to load the neural network weights.

#### Step 3: Connect BRAM to the Processing Modules
- Connect `audio_bram.v` to `fft.v` (to extract frequency features).
- Connect `fft.v` to `mel_filterbank.v` (to extract MFCC features).
- Connect `mel_filterbank.v` to `dense_layer.v` (to classify keyword).
- Connect `dense_layer.v` to `softmax.v` (to pick the best keyword).
- Send result to `uart_display.v` (to display classification result).

#### Step 4: Synthesize, Implement & Generate Bitstream
- Run Synthesis.
- Run Implementation.
- Generate Bitstream (.bit file).
- Load onto Cora Z7 FPGA.

## File Conversion & Processing Flow
### 1. Audio File Processing (Pre-Recorded Audio)
 speech.wav (Audio File) 
    ⬇ (Convert to PCM)
 speech.pcm (Raw 16-bit PCM)  
    ⬇ (Convert for FPGA BRAM)
 audio.coe  (Needed on FPGA)  

### 2. Neural Network Weights Processing
 Pre-Trained Model Weights (fc1_weights.txt, fc1_biases.txt, fc2_weights.txt, fc2_biases.txt)
    ⬇ (Convert to FPGA BRAM Format)
 fc1_weights.coe  (Needed on FPGA)  
 fc1_biases.coe  (Needed on FPGA)  
 fc2_weights.coe  (Needed on FPGA)  
 fc2_biases.coe  (Needed on FPGA)  

### 3. Final Files Needed for FPGA Implementation
 Verilog Logic Files (`.v` files)  (Logic to process audio and classify speech)
 BRAM Initialization Files (`.coe`)  (Needed for FPGA Memory)

 Final Files on FPGA:
- `audio.coe`
- `fc1_weights.coe`, `fc1_biases.coe`
- `fc2_weights.coe`, `fc2_biases.coe`
- `audio_bram.v`, `fft.v`, `mel_filterbank.v`, `dense_layer.v`, `softmax.v`, `uart_display.v`, `top_module.v`
