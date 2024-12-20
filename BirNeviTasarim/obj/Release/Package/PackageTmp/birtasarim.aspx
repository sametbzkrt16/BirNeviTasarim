<%@ Page Title="" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="birtasarim.aspx.cs" Inherits="BirNeviTasarim.birtasarim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>
    .center-content {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 100vh;
        text-align: center;
        color: #fff;
        font-family: 'Arial', sans-serif;
        background: linear-gradient(45deg, #32cd32, #1e90ff, #9400d3);
        margin-top: 20px;
    }

    /* Başlık */
    .center-content h1 {
        font-size: 2.5rem;
        margin-bottom: 20px;
        word-wrap: break-word; /* Uzun kelimeleri satır sonunda kırar */
        padding: 0 15px; /* Mobilde daha iyi uyum için kenarlardan boşluk ekledik */
    }

    /* Buton */
    .center-content .btn {
        background-color: #ff6347;
        color: white;
        padding: 15px 30px;
        border-radius: 50px;
        text-decoration: none;
        font-size: 1.2em;
        box-shadow: 0 5px 15px rgba(255, 99, 71, 0.3);
        transition: all 0.3s;
        display: inline-block; /* Butonun boyutunun mobilde daha uygun olması için */
    }

    .center-content .btn:hover {
        background-color: #ff4500;
        box-shadow: 0 10px 20px rgba(255, 99, 71, 0.5);
        transform: scale(1.1);
    }

    /* Mobil uyumlu stil */
    @media (max-width: 768px) {
        .center-content h1 {
            font-size: 1.8rem; /* Başlık boyutunu mobilde daha küçük yapıyoruz */
            margin-bottom: 15px;
            padding: 0 10px; /* Kenarlarda daha fazla boşluk */
        }

        .center-content .btn {
            padding: 12px 25px; /* Buton boyutunu mobilde küçültüyoruz */
            font-size: 1em;
        }
    }

    /* Tablet ve küçük ekranlar için daha fazla uyum */
    @media (max-width: 480px) {
        .center-content h1 {
            font-size: 1.5rem; /* Çok küçük ekranlar için başlık boyutunu daha da küçültüyoruz */
            margin-bottom: 10px;
        }

        .center-content .btn {
            padding: 10px 20px;
            font-size: 0.9em;
        }
    }
</style>


    <div class="center-content">
    <h1>Hayalindeki web sitesini gerçeğe dönüştürmek ister misin?</h1>
        <a href="/tasarimtalebi.aspx" class="btn">Tasarım Talebi Oluştur</a>
    </div>
</asp:Content>
