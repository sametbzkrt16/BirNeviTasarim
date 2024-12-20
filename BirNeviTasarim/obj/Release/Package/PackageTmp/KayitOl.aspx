<%@ Page Title="Kayıt Ol" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="KayitOl.aspx.cs" Inherits="BirNeviTasarim.KayitOl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            margin-top: 80px; /* Üst menü ile içerik arasına boşluk ekledik */
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
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838;
        }

        .giris-btn {
            background-color: #007bff;
        }

        .giris-btn:hover {
            background-color: #0056b3;
        }

        /* Mobil uyumlu tasarım */
        @media (max-width: 768px) {
            form {
                max-width: 90%; /* Form genişliğini mobilde %90 yapalım */
                margin-top: 20px;
            }

            .form-group input {
                width: 100%; /* Input alanlarının genişliği mobilde %100 olacak şekilde ayarlandı */
            }

            button {
                width: 100%; /* Button genişliği mobilde %100 olacak şekilde ayarlandı */
            }
        }
    </style>

    <form id="formKayitOl" runat="server">
        <h2>Kayıt Ol</h2>
        <div class="form-group">
            <label for="txtKullaniciAdi">Kullanıcı Adı:</label>
            <asp:TextBox ID="txtKullaniciAdi" runat="server" Placeholder="Kullanıcı adınızı girin" />
        </div>
        <div class="form-group">
            <label for="txtSifre">Şifre:</label>
            <asp:TextBox ID="txtSifre" runat="server" TextMode="Password" Placeholder="Şifrenizi girin" />
        </div>
        <div class="form-group">
            <label for="txtEmail">E-posta:</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="E-posta adresinizi girin" />
        </div>
        <button type="submit" runat="server" onserverclick="btnKayitOl_Click">Kayıt Ol</button>

        <hr>
        
        <!-- Giriş yap butonu -->
        <button type="button" class="giris-btn" onclick="location.href='Giris.aspx'">Zaten Hesabım Var, Giriş Yap</button>
    </form>
</asp:Content>
