using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BirNeviTasarim
{
    public partial class siparisler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kullanıcı oturum kontrolü
            if (Session["KullaniciID"] == null)
            {
                // Eğer kullanıcı giriş yapmamışsa, Login sayfasına yönlendirme
                Response.Redirect("KayitOl.aspx");
            }

            if (!IsPostBack)
            {
                LoadSiparisler();
            }
        }

        private void LoadSiparisler()
        {
            // Veritabanı bağlantısı
            string connectionString = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Kullanıcının siparişlerini çekmek için SQL sorgusu
                    string query = @"
                        SELECT TasarimTuru, Butce, Aciklama, TalepTarihi
                        FROM Siparisler
                        WHERE KullaniciID = @KullaniciID";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@KullaniciID", Session["KullaniciID"]);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // GridView'e veri bağlama
                    gvSiparisler.DataSource = dt;
                    gvSiparisler.DataBind();
                }
                catch (Exception ex)
                {
                    // Hataları kullanıcıya göster
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Bir hata oluştu: " + ex.Message.Replace("'", "\\'") + "');", true);
                }
            }
        }

        protected void gvSiparisler_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Satırlara özel işlevsellik (gerekirse)
            }
        }
    }
}
