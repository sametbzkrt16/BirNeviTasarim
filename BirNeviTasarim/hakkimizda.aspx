<%@ Page Title="Hakkımızda" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="hakkimizda.aspx.cs" Inherits="BirNeviTasarim.hakkimizda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <style>
        /* Genel Hakkımızda Container */
        .hakkimizda-container {
            max-width: 1000px;
            margin: 20px auto;
            padding: 30px;
            background: linear-gradient(135deg, #ff7f50, #ff1493, #1e90ff); /* Canlı renk geçişi */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 80px; /* Üst menü ile içerik arasına boşluk ekledik */
            color: white; /* Yazılar için beyaz renk */
        }

        /* Hakkımızda Metni */
        .hakkimizda-text {
            font-size: 1.2rem;
            line-height: 1.6;
            color: #f0f0f0; /* Metin rengi daha açık beyaz */
            margin-bottom: 20px;
            width: 100%;
            text-align: justify; /* Yazıyı iki yana yasladık */
        }

        /* Hakkımızda Görseller */
        .hakkımızda-images {
            display: flex;
            justify-content: center; /* Görselleri ortaladık */
            gap: 15px;
            flex-wrap: wrap;
            width: 100%;
        }

        .hakkımızda-images img {
            max-width: 250px; /* Görselin genişliğini küçülttük */
            width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .hakkımızda-images img:hover {
            transform: scale(1.05); /* Görsellere hover efekti ekledik */
        }

        /* Responsive Tasarım */
        @media (max-width: 768px) {
            .hakkimizda-container {
                flex-direction: column;
                padding: 20px; /* Mobilde içeriğe biraz daha boşluk ekledik */
            }

            .hakkimizda-images {
                justify-content: flex-start; /* Görsellerin hizasını sola aldık */
            }

            .hakkimizda-images img {
                max-width: 80%; /* Mobilde görsellerin genişliğini %80'e düşürdük */
                margin-bottom: 15px;
            }

            .hakkimizda-text {
                font-size: 1rem; /* Mobilde metin boyutunu küçültüyoruz */
            }
        }

        /* Çok küçük ekranlar için uyumluluk */
        @media (max-width: 480px) {
            .hakkimizda-container {
                padding: 15px; /* Küçük ekranlar için içeriği sıkıştırdık */
            }

            .hakkimizda-text {
                font-size: 0.9rem; /* Çok küçük ekranlar için daha da küçük metin */
            }
        }
    </style>

    <div class="hakkimizda-container">
        <!-- Görseli Başlık yerine buraya entegre ettik -->
        <div class="hakkimizda-images" runat="server" id="hakkimizdaImages">
        </div>
        <div id="hakkimizdaText" class="hakkimizda-text" runat="server"></div>
    </div>
</asp:Content>
