<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admingiris.aspx.cs" Inherits="BirNeviTasarim.admingiris" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Giriş</title>
    <style>
        /* Genel Stil */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Form Konteyneri */
        .form-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        /* Başlık */
        h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Input alanları */
        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
            box-sizing: border-box;
        }

        /* Button */
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        /* Mesaj */
        .message {
            margin-top: 10px;
            font-size: 14px;
            color: red;
        }

        /* Etiketler */
        label {
            display: block;
            text-align: left;
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Admin Giriş</h2>
            <div>
                <label for="txtKullaniciAdi">Kullanıcı Adı:</label>
                <asp:TextBox ID="txtKullaniciAdi" runat="server" CssClass="form-control" placeholder="Kullanıcı adı girin"></asp:TextBox>
            </div>
            <div>
                <label for="txtSifre">Şifre:</label>
                <asp:TextBox ID="txtSifre" runat="server" TextMode="Password" CssClass="form-control" placeholder="Şifrenizi girin"></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="btnGiris" runat="server" Text="Giriş Yap" OnClick="btnGiris_Click" CssClass="btn" />
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
