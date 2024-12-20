<%@ Page Title="Giriş Yap" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="Giris.aspx.cs" Inherits="BirNeviTasarim.Giris" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
  
        form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            margin-top: 170px; /* Üst menü ile içerik arasına boşluk ekledik */
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%; /* Mobil uyumlu genişlik */
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%; /* Butonun da mobil uyumlu olması için genişliği %100 yapalım */
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Mobil uyumluluk için medya sorgusu */
        @media (max-width: 768px) {
            form {
                max-width: 100%; /* Formun genişliği cihaz ekranına göre ayarlanacak */
                margin-top: 120px; /* Üst boşluk küçültülecek */
            }

            .form-group input {
                width: 100%; /* Input elemanları mobilde tam genişlik alacak */
            }

            button {
                width: 100%; /* Buton genişliği %100 olacak */
            }
        }

        /* Çok küçük ekranlar için uyumluluk */
        @media (max-width: 480px) {
            form {
                margin-top: 100px; /* Üst boşluk daha da küçültülecek */
            }

            h2 {
                font-size: 1.8rem; /* Başlık boyutunu daha küçük yapalım */
            }

            button {
                font-size: 14px; /* Buton yazı boyutunu küçük ekranlarda küçültüyoruz */
            }
        }
   </style>
    <form id="formGirisYap" runat="server">
        <h2>Giriş Yap</h2>
        <div class="form-group">
            <label for="txtKullaniciAdi">Kullanıcı Adı:</label>
            <asp:TextBox ID="txtKullaniciAdi" runat="server" Placeholder="Kullanıcı adınızı girin"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtSifre">Şifre:</label>
            <asp:TextBox ID="txtSifre" runat="server" TextMode="Password" Placeholder="Şifrenizi girin"></asp:TextBox>
        </div>
        <button type="submit" runat="server" onserverclick="btnGirisYap_Click">Giriş Yap</button>
    </form>
</asp:Content>
