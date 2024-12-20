using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace BirNeviTasarim
{
    public partial class tasarimtalebi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kullanıcı oturum kontrolü sadece KullaniciID ile yapılır
            if (Session["KullaniciID"] == null)
            {
                // Eğer kullanıcı giriş yapmamışsa, Login sayfasına yönlendirme
                Response.Redirect("KayitOl.aspx");
            }

            // Eğer form daha önce gönderildiyse, kullanıcıya uyarı göster
            if (Session["FormSubmitted"] != null && (bool)Session["FormSubmitted"])
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Form zaten gönderildi.');", true);
            }
        }


        protected void btnTalepGönder_Click(object sender, EventArgs e)
        {
            // Veritabanı bağlantısı
            string connectionString = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Talepler tablosuna veri ekleme
                    string talepQuery = @"
                        INSERT INTO Talepler (AdSoyad, Email, Telefon, Aciklama, TasarimTuru, Butce, TeslimTarihi, KullaniciID) 
                        VALUES (@AdSoyad, @Email, @Telefon, @Aciklama, @TasarimTuru, @Butce, @TeslimTarihi, @KullaniciID)";

                    SqlCommand cmdTalep = new SqlCommand(talepQuery, conn);

                    cmdTalep.Parameters.AddWithValue("@AdSoyad", Session["AdSoyad"] ?? txtAdSoyad.Text.Trim());
                    cmdTalep.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmdTalep.Parameters.AddWithValue("@Telefon", txtTelefon.Text.Trim());
                    cmdTalep.Parameters.AddWithValue("@Aciklama", txtAciklama.Text.Trim());
                    cmdTalep.Parameters.AddWithValue("@TasarimTuru", ddlTasarimTuru.SelectedValue);
                    cmdTalep.Parameters.AddWithValue("@Butce", txtBütce.Text.Trim());
                    cmdTalep.Parameters.AddWithValue("@TeslimTarihi", DateTime.Parse(txtTeslimTarihi.Text.Trim()));
                    cmdTalep.Parameters.AddWithValue("@KullaniciID", Session["KullaniciID"]);

                    int resultTalep = cmdTalep.ExecuteNonQuery();

                    if (resultTalep > 0)
                    {
                        // Form başarıyla gönderildiğinde oturum bilgisi güncelle
                        Session["FormSubmitted"] = true;

                        // Siparişler tablosuna aynı verileri ekle
                        string siparisQuery = @"
                            INSERT INTO Siparisler (KullaniciID, TasarimTuru, Butce, Aciklama, TalepTarihi) 
                            VALUES (@KullaniciID, @TasarimTuru, @Butce, @Aciklama, @TalepTarihi)";

                        SqlCommand cmdSiparis = new SqlCommand(siparisQuery, conn);

                        cmdSiparis.Parameters.AddWithValue("@KullaniciID", Session["KullaniciID"]);
                        cmdSiparis.Parameters.AddWithValue("@TasarimTuru", ddlTasarimTuru.SelectedValue);
                        cmdSiparis.Parameters.AddWithValue("@Butce", txtBütce.Text.Trim());
                        cmdSiparis.Parameters.AddWithValue("@Aciklama", txtAciklama.Text.Trim());
                        cmdSiparis.Parameters.AddWithValue("@TalepTarihi", DateTime.Now);

                        int resultSiparis = cmdSiparis.ExecuteNonQuery();

                        if (resultSiparis > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Tasarım talebiniz başarıyla gönderildi ve siparişleriniz kaydedildi.');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sipariş kaydedilemedi, lütfen tekrar deneyin.');", true);
                        }
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bir hata oluştu, lütfen tekrar deneyin.');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Hataları kullanıcıya göster
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bir hata oluştu: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
            }
        }
    }
}
