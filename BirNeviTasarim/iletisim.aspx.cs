

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace BirNeviTasarim
{
    public partial class iletisim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadIletisimBilgileri();
            }
        }

        private void LoadIletisimBilgileri()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT TOP 1 Instagram, Mail, WhatsApp FROM Iletisim";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string instagram = reader["Instagram"].ToString();
                    string mail = reader["Mail"].ToString();
                    string whatsapp = reader["WhatsApp"].ToString();

                    // Dinamik HTML oluşturuluyor
                    string iletisimHtml = $@"
                <h2>İletişim Bilgileri</h2>
                <p>Bize sosyal medya üzerinden de ulaşabilirsiniz!</p>
                <div class='ikon-container'>
                    <a href='{instagram}' target='_blank' title='Instagram'>
                        <i class='fab fa-instagram'></i>
                    </a>
                    <a href='mailto:{mail}' target='_blank' title='Mail'>
                        <i class='fas fa-envelope'></i>
                    </a>
                    <a href='https://wa.me/{whatsapp}' target='_blank' title='WhatsApp'>
                        <i class='fab fa-whatsapp'></i>
                    </a>
                </div>";

                    // HTML'yi iletişim container'ına ekliyoruz
                    iletisimContainer.InnerHtml = iletisimHtml;
                }
            }
        }

    }

}