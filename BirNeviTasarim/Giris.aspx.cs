using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BirNeviTasarim
{
    public partial class Giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Giriş yap butonuna tıklama işlemi
        protected void btnGirisYap_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Kullanıcı adı ve şifreyi kontrol etme (AdSoyad'ı sorgudan çıkardık)
                    string query = "SELECT KullaniciID FROM Kullanici WHERE KullaniciAdi = @KullaniciAdi AND Sifre = @Sifre";
                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@KullaniciAdi", txtKullaniciAdi.Text.Trim());
                    cmd.Parameters.AddWithValue("@Sifre", txtSifre.Text.Trim());

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();
                        // Kullanıcıyı giriş yaptıktan sonra oturum açma
                        Session["KullaniciID"] = reader["KullaniciID"];

                        // Giriş başarılı, tasarım talebi sayfasına yönlendir
                        Response.Redirect("tasarimtalebi.aspx");
                    }
                    else
                    {
                        // Hatalı giriş
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Kullanıcı adı veya şifre yanlış!');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Hata loglama
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bir hata oluştu: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
            }
        }
    }
}
