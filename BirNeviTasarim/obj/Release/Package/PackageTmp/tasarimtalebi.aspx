<%@ Page Title="Tasarım Talebi" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="tasarimtalebi.aspx.cs" Inherits="BirNeviTasarim.tasarimtalebi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <!DOCTYPE html>
<html lang="tr">
<head>
   <meta charset="utf-8" />
   <title>Tasarım Talebi</title>
   <style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

form {
    background: #ffffff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    width: 650px;
}

.step {
    display: none;
}

.step.active {
    display: block;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

.form-group input, .form-group select {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.button-group {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

button {
    padding: 16px 32px;
    font-size: 18px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    flex: 1;
    margin: 0 8px;
}

/* Geri Butonu */
/* Geri Butonu */
button.back {
    background: #FF5733; /* Canlı turuncu */
    color: white;
    transition: background 0.3s, transform 0.3s;
}

button.back:hover {
    background: #C70039; /* Daha koyu kırmızımsı turuncu */
    transform: scale(1.1); /* Hafif büyüme efekti */
}

/* Devam Butonu */
button.next {
    background: #1E90FF; /* Canlı mavi */
    color: white;
    transition: background 0.3s, transform 0.3s;
}

button.next:hover {
    background: #4682B4; /* Daha koyu mavi */
    transform: scale(1.1); /* Hafif büyüme efekti */
}

/* Gönder Butonu */
button.submit {
    width: 120px;
    padding: 16px 32px;
    font-size: 18px;
    font-weight: bold;
    background: #28a745; /* Canlı yeşil */
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 20px;
    transition: background 0.3s, transform 0.3s;
}

button.submit:hover {
    background: #218838; /* Daha koyu yeşil */
    transform: scale(1.1); /* Hafif büyüme efekti */
}

button.submit:disabled {
    background: #bdc3c7;
    cursor: not-allowed;
    transform: none; /* Disabled durumda efekt olmamalı */
}


@media (max-width: 768px) {
    body {
        height: auto;
        padding: 20px 0; /* Daha iyi dikey hizalama */
    }

    form {
        width: 95%; /* Form genişliğini ekranın %95'ine ayarladım */
        margin: 10px auto; /* Orta hizalama */
        padding: 15px; /* Daha küçük padding */
    }

    .form-group label {
        font-size: 14px; /* Etiketleri küçült */
    }

    .form-group input,
    .form-group select {
        padding: 8px; /* Input padding'ini küçült */
        font-size: 14px;
    }

    button {
        padding: 10px 16px; /* Buton boyutunu küçült */
        font-size: 14px; /* Buton yazı boyutunu küçült */
        margin: 5px 0; /* Dikey boşluklar */
        flex: none; /* Butonların esnekliğini kaldır */
        width: 100%; /* Tam genişlik */
    }

    .button-group {
        flex-direction: column; /* Butonları alt alta yerleştir */
    }
}

@media (max-width: 480px) {
    .form-group input,
    .form-group select {
        font-size: 12px;
        padding: 6px; /* Daha da küçült */
    }

    button {
        font-size: 12px; /* Küçük ekranlar için buton yazı boyutu */
        padding: 8px 12px;
    }
}

   </style>
   <script>
       // Adım geçişi için doğrulama fonksiyonu
       function nextStep(currentStepId, nextStepId) {
           const currentStep = document.getElementById(currentStepId);
           const inputs = currentStep.querySelectorAll('input, select');

           for (let input of inputs) {
               if (!input.value.trim()) {
                   alert("Lütfen tüm alanları doldurun.");
                   return;
               }
           }

           // Eğer tüm alanlar doluysa adım değiştir
           currentStep.classList.remove('active');
           document.getElementById(nextStepId).classList.add('active');
           checkFormCompletion();
       }

       function previousStep(currentStepId, previousStepId) {
           document.getElementById(currentStepId).classList.remove('active');
           document.getElementById(previousStepId).classList.add('active');
       }

       // Form tamamlanıp tamamlanmadığını kontrol et
       function checkFormCompletion() {
           const steps = document.querySelectorAll('.step input, .step select');
           const submitButton = document.getElementById('btnTalepGönder');
           let allFilled = true;

           steps.forEach((step) => {
               if (!step.value.trim()) {
                   allFilled = false;
               }
           });

           // Tüm alanlar doluysa butonu etkinleştir
           submitButton.disabled = !allFilled;
       }

       // Her adım geçişinde bu fonksiyon çağrılacak
       function nextStep(currentStepId, nextStepId) {
           const currentStep = document.getElementById(currentStepId);
           const inputs = currentStep.querySelectorAll('input, select');

           for (let input of inputs) {
               if (!input.value.trim()) {
                   alert("Lütfen tüm alanları doldurun.");
                   return;
               }
           }

           currentStep.classList.remove('active');
           document.getElementById(nextStepId).classList.add('active');
           checkFormCompletion();
       }

   </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Adım 1 -->
        <div id="step1" class="step active">
            <div class="form-group">
                <asp:Label ID="lblAdSoyad" runat="server" Text="Ad ve Soyad:" />
                <asp:TextBox ID="txtAdSoyad" runat="server" placeholder="Adınızı ve soyadınızı girin" />
            </div>
            <button type="button" onclick="nextStep('step1', 'step2')">Devam</button>
        </div>

        <!-- Adım 2 -->
        <div id="step2" class="step">
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="E-posta Adresi:" />
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="E-posta adresinizi girin" />
            </div>
            <button type="button" onclick="previousStep('step2', 'step1')" class="back">Geri</button>
            <button type="button" onclick="nextStep('step2', 'step3')">Devam</button>
        </div>

        <!-- Adım 3 -->
        <div id="step3" class="step">
            <div class="form-group">
                <asp:Label ID="lblTelefon" runat="server" Text="Telefon Numarası:" />
                <asp:TextBox ID="txtTelefon" runat="server" placeholder="Telefon numaranızı girin" />
            </div>
            <button type="button" onclick="previousStep('step3', 'step2')" class="back">Geri</button>
            <button type="button" onclick="nextStep('step3', 'step4')">Devam</button>
        </div>

        <!-- Adım 4 -->
        <div id="step4" class="step">
            <div class="form-group">
                <asp:Label ID="lblAciklama" runat="server" Text="Tasarım İsteğiniz:" />
                <asp:TextBox ID="txtAciklama" runat="server" TextMode="MultiLine" placeholder="Tasarım isteğinizi açıklayın" Rows="4" />
            </div>
            <button type="button" onclick="previousStep('step4', 'step3')" class="back">Geri</button>
            <button type="button" onclick="nextStep('step4', 'step5')">Devam</button>
        </div>

        <!-- Adım 5 -->
        <div id="step5" class="step">
            <div class="form-group">
                <asp:Label ID="lblTasarimTuru" runat="server" Text="Tasarım Türü:" />
                <asp:DropDownList ID="ddlTasarimTuru" runat="server">
                    <asp:ListItem Text="Portföy" Value="Portföy" />
                    <asp:ListItem Text="E-ticaret" Value="E-ticaret" />
                    <asp:ListItem Text="Blog" Value="Blog" />
                    <asp:ListItem Text="Kurumsal" Value="Kurumsal" />
                        <asp:ListItem Text="Logo Tasarımı" Value="Logo Tasarımı" />

                </asp:DropDownList>
            </div>
            <button type="button" onclick="previousStep('step5', 'step4')" class="back">Geri</button>
            <button type="button" onclick="nextStep('step5', 'step6')">Devam</button>
        </div>

        <!-- Adım 6 -->
        <div id="step6" class="step">
            <div class="form-group">
                <asp:Label ID="lblBütce" runat="server" Text="Bütçe:" />
                <asp:TextBox ID="txtBütce" runat="server" placeholder="Tahmini bütçenizi girin" />
            </div>
            <button type="button" onclick="previousStep('step6', 'step5')" class="back">Geri</button>
            <button type="button" onclick="nextStep('step6', 'step7')">Devam</button>
        </div>

        <!-- Adım 7 -->
        <div id="step7" class="step">
            <div class="form-group">
                <asp:Label ID="lblTeslimTarihi" runat="server" Text="Teslim Tarihi:" />
                <asp:TextBox ID="txtTeslimTarihi" runat="server" TextMode="Date" placeholder="Tahmini bütçenizi girin"/>
            </div>
            <button type="button" onclick="previousStep('step7', 'step6')" class="back">Geri</button>
<asp:Button ID="btnTalepGönder" runat="server" Text="Gönder" OnClick="btnTalepGönder_Click" CssClass="submit" Enabled="true" />
        </div>
    </form>
</body>
</html>
</asp:Content>

