<%@ Page Title="Siparişlerim" Language="C#" MasterPageFile="~/Nevi.Master" AutoEventWireup="true" CodeBehind="siparisler.aspx.cs" Inherits="BirNeviTasarim.siparisler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Genel sayfa stili */
        .siparis-container {
            padding: 30px;
            background: linear-gradient(135deg, #ff7f50, #ff1493, #1e90ff); /* Canlı renk geçişi */
            border-radius: 8px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            margin-top: 80px; /* Üst menü ile içerik arasına boşluk ekledik */
            font-family: 'Arial', sans-serif;
        }

        .siparis-header {
            font-size: 2.5rem;
            color: #333;
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* GridView tablosu stili */
        .styled-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden; /* Köşeleri yuvarlaklaştırmak için */
        }

        .styled-grid th, .styled-grid td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .styled-grid th {
            background-color: #28a745;
            color: white;
            font-weight: bold;
        }

        .styled-grid tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        .styled-grid tr:hover {
            background-color: #e2e2e2;
        }

        .styled-grid td, .styled-grid th {
            font-size: 1.1rem;
        }

        .styled-grid td {
            color: #555;
        }

        /* Buton için stil ekleme */
        .btn-view {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }

        .btn-view:hover {
            background-color: #0056b3;
            transition: background-color 0.3s ease;
        }

        /* Responsive tasarım */
        @media (max-width: 768px) {
            .siparis-container {
                padding: 15px;
            }

            .siparis-header {
                font-size: 2rem;
            }

            .styled-grid th, .styled-grid td {
                font-size: 0.9rem;
                padding: 10px;
            }

            .btn-view {
                padding: 6px 12px;
            }
        }
    </style>

    <!-- Form etiketi eklendi -->
    <form id="form1" runat="server">
        <div class="siparis-container">
            <h2 class="siparis-header">Siparişlerim</h2>

            <asp:GridView ID="gvSiparisler" runat="server" AutoGenerateColumns="False" EmptyDataText="Hiç siparişiniz yok." 
                OnRowDataBound="gvSiparisler_RowDataBound" CssClass="table table-striped styled-grid">
                <Columns>
                    <asp:BoundField DataField="TasarimTuru" HeaderText="Tasarım Türü" SortExpression="TasarimTuru" />
                    <asp:BoundField DataField="Butce" HeaderText="Bütçe" SortExpression="Butce" />
                    <asp:BoundField DataField="Aciklama" HeaderText="Açıklama" SortExpression="Aciklama" />
                    <asp:BoundField DataField="TalepTarihi" HeaderText="Talep Tarihi" SortExpression="TalepTarihi" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</asp:Content>
