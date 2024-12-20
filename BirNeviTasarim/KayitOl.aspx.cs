using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BirNeviTasarim
{
    public partial class KayitOl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Eğer kullanıcı zaten giriş yapmışsa, ana sayfaya yönlendir
            if (Session["KullaniciID"] != null)
            {
                Response.Redirect("tasarimtalebi.aspx");
            }
        }

        // Kayıt ol butonuna tıklama işlemi
        protected void btnKayitOl_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Kullanıcı adı ve e-posta kontrolü
                    string checkUserQuery = "SELECT COUNT(*) FROM Kullanici WHERE KullaniciAdi = @KullaniciAdi OR Email = @Email";
                    SqlCommand cmdCheck = new SqlCommand(checkUserQuery, conn);

                    cmdCheck.Parameters.AddWithValue("@KullaniciAdi", txtKullaniciAdi.Text.Trim());
                    cmdCheck.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                    int userExists = (int)cmdCheck.ExecuteScalar();

                    if (userExists > 0)
                    {
                        // Kullanıcı adı ya da e-posta zaten kayıtlı
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Kullanıcı adı veya e-posta zaten kayıtlı!');", true);
                    }
                    else
                    {
                        // Yeni kullanıcı kaydını yapma
                        string insertQuery = "INSERT INTO Kullanici (KullaniciAdi, Sifre, Email) VALUES (@KullaniciAdi, @Sifre, @Email)";
                        SqlCommand cmdInsert = new SqlCommand(insertQuery, conn);

                        cmdInsert.Parameters.AddWithValue("@KullaniciAdi", txtKullaniciAdi.Text.Trim());
                        cmdInsert.Parameters.AddWithValue("@Sifre", txtSifre.Text.Trim());
                        cmdInsert.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                        int result = cmdInsert.ExecuteNonQuery();

                        if (result > 0)
                        {
                            // Kayıt başarılı, giriş sayfasına yönlendir
                            Response.Redirect("Giris.aspx");
                        }
                        else
                        {
                            // Hata oluştu
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Kayıt sırasında bir hata oluştu. Lütfen tekrar deneyin.');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Hata loglama
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bir hata oluştu: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
            }
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

                    // Kullanıcı adı ve şifre kontrolü
                    string checkUserQuery = "SELECT KullaniciID, KullaniciAdi FROM Kullanici WHERE Email = @Email AND Sifre = @Sifre";
                    SqlCommand cmdCheck = new SqlCommand(checkUserQuery, conn);

                    cmdCheck.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmdCheck.Parameters.AddWithValue("@Sifre", txtSifre.Text.Trim());

                    SqlDataReader reader = cmdCheck.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();

                        // Oturum açma işlemi
                        Session["KullaniciID"] = reader["KullaniciID"];
                        Session["KullaniciAdi"] = reader["KullaniciAdi"];

                        // Başarıyla giriş yapıldığında tasarım talep sayfasına yönlendir
                        Response.Redirect("tasarimtalebi.aspx");
                    }
                    else
                    {
                        // Kullanıcı bulunamazsa
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Geçersiz e-posta veya şifre!');", true);
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
