using System;
using System.Configuration;
using System.Data.SqlClient;

namespace BirNeviTasarim
{
    public partial class admingiris : System.Web.UI.Page
    {
        protected void btnGiris_Click(object sender, EventArgs e)
        {
            string kullaniciAdi = txtKullaniciAdi.Text.Trim();
            string sifre = txtSifre.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM Admin WHERE KullaniciAdi = @KullaniciAdi AND Sifre = @Sifre";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@KullaniciAdi", kullaniciAdi);
                cmd.Parameters.AddWithValue("@Sifre", sifre); // Şifre hashlenmişse, burada aynı hash yöntemi kullanılmalıdır.

                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    // Başarılı giriş
                    Session["AdminLogin"] = true;
                    Response.Redirect("adminpanel.aspx");
                }
                else
                {
                    // Hatalı giriş
                    lblMessage.Text = "Kullanıcı adı veya şifre hatalı!";
                }
            }
        }
    }
}
