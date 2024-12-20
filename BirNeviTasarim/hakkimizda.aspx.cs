using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace BirNeviTasarim
{
    public partial class hakkimizda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHakkimizda();
            }
        }

        private void LoadHakkimizda()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Metni yükle
                SqlCommand cmd = new SqlCommand("SELECT TOP 1 Metin FROM Hakkimizda ORDER BY ID DESC", conn);
                object metinResult = cmd.ExecuteScalar();
                if (metinResult != null)
                {
                    hakkimizdaText.InnerHtml = metinResult.ToString();
                }

                // Görselleri yükle
                SqlCommand imgCmd = new SqlCommand("SELECT GorselYol FROM Hakkimizda WHERE GorselYol IS NOT NULL", conn);
                SqlDataReader reader = imgCmd.ExecuteReader();
                StringBuilder imagesHtml = new StringBuilder();

                while (reader.Read())
                {
                    string imageUrl = reader["GorselYol"].ToString();
                    // Görsellerin ilkini başlık kısmına yerleştiriyoruz
                    if (imagesHtml.Length == 0)
                    {
                        imagesHtml.AppendFormat("<img id='hakkimizdaImage' src='{0}' alt='Hakkımızda Görseli' />", imageUrl);
                    }
                    else
                    {
                        imagesHtml.AppendFormat("<img src='{0}' alt='Hakkımızda Görseli' />", imageUrl);
                    }
                }

                // Diğer görselleri sayfaya ekliyoruz
                hakkimizdaImages.InnerHtml = imagesHtml.ToString();
            }
        }
    }
}
