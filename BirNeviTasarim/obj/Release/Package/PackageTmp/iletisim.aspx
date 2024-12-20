<%@ Page Title="İletişim" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="iletisim.aspx.cs" Inherits="BirNeviTasarim.iletisim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* İletişim sayfasının ana container'ı */
        .iletisim-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: linear-gradient(135deg, #ff7f50, #ff1493, #1e90ff); /* Canlı renk geçişi */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 140px; /* Üst menü ile içerik arasına boşluk ekledik */
        }

        .iletisim-container h2 {
            font-size: 2.5rem;
            color: #fff;
            margin-bottom: 30px; /* Başlık altına biraz daha boşluk ekledik */
        }

        .iletisim-container p {
            font-size: 1.2rem;
            color: #fff;
            margin-bottom: 25px; /* Paragraflar arasında daha fazla boşluk */
            line-height: 1.7;
        }

        /* Her bir iletişim bilgisi için stil */
        .iletisim-item {
            margin: 20px 0;
            font-size: 1.5rem; /* Daha büyük yazı boyutu */
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff; /* Yazı rengi beyaz yapıldı */
        }

        .iletisim-item a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
            margin-left: 10px;
            transition: color 0.3s ease;
        }

        .iletisim-item a:hover {
            color: #388E3C;
            text-decoration: underline;
        }

        /* İkon stilleri */
        .iletisim-item i {
            font-size: 2rem; /* İkon boyutunu büyütüyoruz */
            color: #4CAF50;
            transition: color 0.3s ease;
        }

        .iletisim-item i:hover {
            color: #388E3C;
        }

        /* Araya ekstra boşluk ekleyelim */
        .iletisim-item + .iletisim-item {
            margin-top: 40px; /* Bağlantılar arasına ekstra boşluk ekledik */
        }

        /* Sosyal medya ikonlarını hizalayalım */
        .ikon-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 40px;
        }

        .ikon-container a {
            font-size: 2rem;
            color: #fff;
            transition: color 0.3s ease;
        }

        .ikon-container a:hover {
            color: #4CAF50;
        }

        /* Responsive tasarım (mobil uyumlu) */
        @media (max-width: 768px) {
            .iletisim-container {
                padding: 20px;
            }

            .iletisim-item {
                font-size: 1.2rem;
                margin-top: 30px; /* Mobilde aralar biraz daha geniş olsun */
            }

            .ikon-container a {
                font-size: 1.8rem; /* İkonlar mobilde biraz daha küçük olacak */
            }
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <div class="iletisim-container" id="iletisimContainer" runat="server">
        <h2>İletişim Bilgileri</h2>
        <p>Bize sosyal medya üzerinden de ulaşabilirsiniz!</p>

        <!-- Sosyal medya ikonları -->
        <div class="ikon-container">
            <a href="<%# Eval("Instagram") %>" target="_blank" title="Instagram">
                <i class="fab fa-instagram"></i>
            </a>
            <a href="mailto:<%# Eval("Mail") %>" target="_blank" title="Mail">
                <i class="fas fa-envelope"></i>
            </a>
            <a href="https://wa.me/<%# Eval("WhatsApp") %>" target="_blank" title="WhatsApp">
                <i class="fab fa-whatsapp"></i>
            </a>
        </div>
    </div>
</asp:Content>
