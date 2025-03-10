# 🛎 Citation

If you find our work helpful for your research, please cite:

```bib
@article{li2025dppad,
  title={DPPAD-IE: Dynamic Polyhedra Permutating and Arnold Diffusing Medical Image Encryption Using 2D Cross Gaussian Hyperchaotic Map},
  author={Li, Quanjun and Li, Qian and Ling, Bingo Wing-Kuen and Pun, Chi-Man and Huang, Guoheng and Yuan, Xiaochen and Zhong, Guo and Ayouni, Sarra and Chen, Jianwu},
  journal={IEEE Transactions on Consumer Electronics},
  year={2025},
  publisher={IEEE}
}
```

# 📋DPPAD-IE

DPPAD-IE: Dynamic Polyhedra Permutating and Arnold Diffusing Medical Image Encryption Using 2D Cross Gaussian Hyperchaotic Map

Quanjun Li , Qian Li , Bingo Wing-Kuen Ling, Chi-Man Pun, Guoheng Huang, Xiaochen Yuan, Guo Zhong, Sarra Ayouni, and Jianwu Chen

### List of Universities and Research Institutions  

- **Guangdong Province**  
  - [Guangdong University of Technology](https://www.gdut.edu.cn)  
  - [Guangdong University of Foreign Studies](https://www.gdufs.edu.cn)  
  - [Wuyi University](https://www.wyu.edu.cn)  

- **Macau SAR**  
  - [University of Macau](https://www.um.edu.mo)  
  - [Macau Polytechnic University](https://www.mpu.edu.mo)  

- **Saudi Arabia**  
  - [King Saud University](https://www.ksu.edu.sa)  

- **Fujian Province**  
  - [Fujian Medical University Union Hospital](https://www.fjmu.edu.cn)  
  - [Fujian Medical University](https://www.fjmu.edu.cn)  
  - [Clinical Research Center for Radiology and Radiotherapy of Fujian Province](#)  

## 🚧 Installation 
Requirements: `Matlab 2024`


## 1. Preparing the Dataset  

To ensure robust encryption and evaluation, we first prepare the datasets used in this study. The selected datasets include:  

### Datasets  
- **Brain Tumors Dataset**  
  - A medical imaging dataset containing brain tumor scans.  
  - Used for testing encryption robustness in medical image security.  

- **Computer-Aided Diagnostic (CAD) Dataset**  
  - A dataset of chest X-ray images for automated disease classification.  
  - Utilized to evaluate the impact of encryption on deep ensemble learning models.  

## 2. Encrypting and Obtaining the Outputs  

Once the datasets are prepared, the next step is to apply the encryption algorithm to transform the images.  

- Run **`encrypt.m`** to execute the encryption process.  
- After execution, the encrypted images are generated and stored for further analysis.  
- The encrypted outputs can be used for **security validation, decryption testing, and performance evaluation**.  

This encryption process ensures the confidentiality and integrity of sensitive medical images while enabling secure AI-driven diagnostics.  


  
# 🧧 Acknowledgement  

This work was supported by the **Key Areas Research and Development Program of Guangzhou** (Grant No. 2023B01J0029), the **Guangdong Provincial Key Laboratory of Cyber-Physical System** (Grant No. 2020B1212060069), and the **University of Macau** (Grant No. MYRG2022-00190-FST).  

Additionally, this research was partially funded by the **Science and Technology Development Fund, Macau SAR** (Grant No. 0141/2023/RIA2), the **Guangdong Basic and Applied Basic Research Foundation** (Grant Nos. 2024A1515011729 and 0193/2023/RIA3), and the **Researchers Supporting Project** (Grant No. RSPD2025R564) from **King Saud University, Riyadh, Saudi Arabia**.  

We sincerely appreciate the generous support from these institutions.  

