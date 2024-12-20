using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace BirNeviTasarim
{
    public partial class Projelerimiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjeler();
            }
        }

        private void LoadProjeler()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT ProjeAdi, ProjeGorsel, ProjeAciklama FROM Projeler";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    // Dinamik HTML oluşturuluyor
                    string projeHtml = $@"
                        <div class='proje-item'>
                            <img src='{reader["ProjeGorsel"]}' alt='{reader["ProjeAdi"]}' />
                            <h3>{reader["ProjeAdi"]}</h3>
                            <p>{reader["ProjeAciklama"]}</p>
                        </div>";
                    // HTML'yi projeContainer içine ekliyoruz
                    projeContainer.InnerHtml += projeHtml;
                }
            }
        }
    }
}
