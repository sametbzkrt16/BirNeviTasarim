<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminpanel.aspx.cs" Inherits="BirNeviTasarim.adminpanel" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Panel - Hakkımızda</title>
    <style>
        /* Genel Stil */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 16px;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

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

        .file-upload {
            margin-bottom: 15px;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .link-container {
            margin-top: 20px;
            text-align: center;
        }

        .link-container a {
            font-size: 16px;
            color: #007bff;
            text-decoration: none;
        }

        .link-container a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <form id="form1" runat="server">
        <div class="container">
            <h2>Hakkımızda Yönetimi</h2>

            <div>
                <label for="txtHakkimizda">Hakkımızda Yazısı:</label>
                <textarea id="txtHakkimizda" runat="server" placeholder="Hakkımızda yazısını girin..." class="form-control"></textarea>
            </div>

            <div>
                <label for="fileHakkimizdaImage">Hakkımızda Görselleri:</label>
                <asp:FileUpload ID="fileHakkimizdaImage" runat="server" AllowMultiple="true" class="form-control file-upload" />
            </div>

            <asp:Button ID="btnSave" runat="server" Text="Kaydet" OnClick="SaveHakkimizda" CssClass="btn" />
                <asp:Button ID="btnDelete" runat="server" Text="Sil" OnClick="DeleteHakkimizda" CssClass="btn" />

            <div class="link-container">
                <a href="hakkimizda.aspx" target="_blank">Hakkımızda Sayfasını Görüntüle</a>
            </div>
        </div>
         <div class="container">
            <h2>Tasarım Talepleri</h2>
            <asp:GridView ID="gvTalepler" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:BoundField DataField="AdSoyad" HeaderText="Ad Soyad" SortExpression="AdSoyad" />
                    <asp:BoundField DataField="Email" HeaderText="E-posta" SortExpression="Email" />
                    <asp:BoundField DataField="Telefon" HeaderText="Telefon" SortExpression="Telefon" />
                    <asp:BoundField DataField="Aciklama" HeaderText="Tasarım İsteği" SortExpression="Aciklama" />
                    <asp:BoundField DataField="TasarimTuru" HeaderText="Tasarım Türü" SortExpression="TasarimTuru" />
                    <asp:BoundField DataField="Butce" HeaderText="Bütçe" SortExpression="Butce" />
                    <asp:BoundField DataField="TeslimTarihi" HeaderText="Teslim Tarihi" SortExpression="TeslimTarihi" />
                    <asp:BoundField DataField="OlusturmaTarihi" HeaderText="Talep Tarihi" SortExpression="OlusturmaTarihi" />
                </Columns>
            </asp:GridView>
        </div>
        <div class="container">
            <h2>Proje Ekle</h2>
            <label>Proje Adı:</label>
            <asp:TextBox ID="txtProjeAdi" runat="server" CssClass="form-control"></asp:TextBox>

            <label>Proje Görseli:</label>
            <asp:FileUpload ID="fileProjeGorsel" runat="server" CssClass="form-control file-upload" />

            <label>Proje Açıklaması:</label>
            <asp:TextBox ID="txtProjeAciklama" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>

            <asp:Button ID="btnProjeEkle" runat="server" Text="Proje Ekle" OnClick="btnProjeEkle_Click" CssClass="btn" />
        </div>
        <div class="container">
    <h2>Projeleri Yönet</h2>
    <asp:GridView ID="gvProjeler" runat="server" AutoGenerateColumns="False" CssClass="table" OnRowCommand="gvProjeler_RowCommand" DataKeyNames="ID">
        <Columns>
            <asp:BoundField DataField="ProjeAdi" HeaderText="Proje Adı" />
            <asp:BoundField DataField="ProjeAciklama" HeaderText="Açıklama" />
            <asp:BoundField DataField="ProjeGorsel" HeaderText="Görsel Yolu" />
            <asp:ButtonField Text="Sil" CommandName="Sil" ButtonType="Button" />
        </Columns>
    </asp:GridView>
</div>


        <div class="container">
            <h2>İletişim Bilgilerini Güncelle</h2>

            <label for="txtInstagram">Instagram Linki:</label>
            <asp:TextBox ID="txtInstagram" runat="server" CssClass="form-control"></asp:TextBox><br>

            <label for="txtMail">Mail:</label>
            <asp:TextBox ID="txtMail" runat="server" CssClass="form-control"></asp:TextBox><br>

            <label for="txtWhatsApp">WhatsApp Numarası:</label>
            <asp:TextBox ID="txtWhatsApp" runat="server" CssClass="form-control"></asp:TextBox><br>

            <asp:Button ID="btnSaveIletisim" runat="server" Text="Kaydet" OnClick="SaveIletisim" CssClass="btn" />
        </div>
    </form>
</body>
</html>
