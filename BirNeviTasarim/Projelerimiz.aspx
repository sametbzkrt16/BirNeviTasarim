<%@ Page Title="Projelerimiz" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="Projelerimiz.aspx.cs" Inherits="BirNeviTasarim.Projelerimiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Projeler için genel container ayarları */
        .proje-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 100px; /* Üst menü ile içerik arasına boşluk ekledik */
            justify-content: space-between;
        }

        /* Her bir proje kartının görünümü */
        .proje-item {
            width: calc(33.33% - 20px);
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .proje-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        /* Proje görseli ayarları */
        .proje-item img {
            width: 100%;
            height: 200px;
            object-fit: cover; /* Görselin düzgün görünmesi için */
            transition: opacity 0.3s ease;
        }

        .proje-item:hover img {
            opacity: 0.8; /* Hover efekti ile görselin opaklık değerini değiştir */
        }

        /* Proje başlıkları için stil */
        .proje-item h3 {
            margin: 15px;
            font-size: 1.6rem;
            color: #333;
            font-weight: bold;
            text-align: center;
        }

        /* Proje açıklamaları için stil */
        .proje-item p {
            margin: 0 15px 15px;
            font-size: 1rem;
            color: #666;
            text-align: center;
        }

        /* Responsive tasarım (mobil uyumlu) */
        @media (max-width: 768px) {
            .proje-item {
                width: calc(50% - 20px);
            }
        }

        @media (max-width: 480px) {
            .proje-item {
                width: 100%;
            }
        }
    </style>

    <div class="proje-container" id="projeContainer" runat="server">
        <!-- Projeler burada listelenecek -->
    </div>
</asp:Content>
