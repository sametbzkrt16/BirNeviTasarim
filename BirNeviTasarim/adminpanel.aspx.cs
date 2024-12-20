using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace BirNeviTasarim
{
    public partial class adminpanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminLogin"] == null || !(bool)Session["AdminLogin"])
            {
                Response.Redirect("admingiris.aspx");
            }
            if (!IsPostBack)
            {
                LoadHakkimizda();
                LoadIletisimBilgileri();
                LoadTalepler();  // Admin paneline tasarım taleplerini yükleyin
                LoadProjeler(); // Projeleri yükle

            }
        }
        protected void DeleteHakkimizda(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Hakkımızda tablosundan en son eklenen metin ve görseli silme
                string deleteQuery = "SELECT TOP 1 GorselYol FROM Hakkimizda ORDER BY ID DESC";
                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                string gorselYol = cmd.ExecuteScalar()?.ToString();

                // Görseli fiziksel olarak silme
                if (!string.IsNullOrEmpty(gorselYol))
                {
                    string filePath = Server.MapPath(gorselYol);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }
                }

                // Hakkımızda verisini silme
                string deleteTextQuery = "DELETE FROM Hakkimizda WHERE ID = (SELECT TOP 1 ID FROM Hakkimizda ORDER BY ID DESC)";
                SqlCommand deleteCmd = new SqlCommand(deleteTextQuery, conn);
                deleteCmd.ExecuteNonQuery();
            }

            // Hakkımızda metnini sıfırlama
            txtHakkimizda.Value = "";

            // Sayfayı tekrar yükleme
            LoadHakkimizda();
        }

        private void LoadHakkimizda()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT TOP 1 Metin FROM Hakkimizda ORDER BY ID DESC", conn);
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    txtHakkimizda.Value = result.ToString();
                }
            }
        }

        protected void SaveHakkimizda(object sender, EventArgs e)
        {
            string metin = txtHakkimizda.Value;

            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Metni kaydet
                SqlCommand cmd = new SqlCommand("INSERT INTO Hakkimizda (Metin) VALUES (@Metin)", conn);
                cmd.Parameters.AddWithValue("@Metin", metin);
                cmd.ExecuteNonQuery();

                // Görselleri kaydet
                if (fileHakkimizdaImage.HasFiles)
                {
                    foreach (var file in fileHakkimizdaImage.PostedFiles)
                    {
                        string fileName = Path.GetFileName(file.FileName);
                        string savePath = Server.MapPath("~/uploads/" + fileName);
                        file.SaveAs(savePath);

                        SqlCommand imgCmd = new SqlCommand("INSERT INTO Hakkimizda (GorselYol) VALUES (@GorselYol)", conn);
                        imgCmd.Parameters.AddWithValue("@GorselYol", "/uploads/" + fileName);
                        imgCmd.ExecuteNonQuery();
                    }
                }
            }
        }

        protected void btnProjeEkle_Click(object sender, EventArgs e)
        {
            string projeAdi = txtProjeAdi.Text;
            string projeAciklama = txtProjeAciklama.Text;
            string projeGorselYolu = "";

            if (fileProjeGorsel.HasFile)
            {
                // Görseli kaydet
                string folderPath = Server.MapPath("~/uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileProjeGorsel.FileName);
                projeGorselYolu = "/uploads/" + fileName;
                fileProjeGorsel.SaveAs(Path.Combine(folderPath, fileName));
            }

            // Veritabanına kaydet
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "INSERT INTO Projeler (ProjeAdi, ProjeGorsel, ProjeAciklama) VALUES (@ProjeAdi, @ProjeGorsel, @ProjeAciklama)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProjeAdi", projeAdi);
                cmd.Parameters.AddWithValue("@ProjeGorsel", projeGorselYolu);
                cmd.Parameters.AddWithValue("@ProjeAciklama", projeAciklama);
                cmd.ExecuteNonQuery();
            }

            // Form temizle
            txtProjeAdi.Text = "";
            txtProjeAciklama.Text = "";
        }
        private void LoadProjeler()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT ID, ProjeAdi, ProjeAciklama, ProjeGorsel FROM Projeler";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                gvProjeler.DataSource = reader;
                gvProjeler.DataBind();
            }
        }
        protected void gvProjeler_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvProjeler.Rows[rowIndex];

                // Proje ID'sini alıyoruz
                int projeId = Convert.ToInt32(gvProjeler.DataKeys[rowIndex].Value);

                // Silme işlemi
                DeleteProje(projeId);

                // Listeyi güncelle
                LoadProjeler();
            }
        }

        private void DeleteProje(int projeId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "DELETE FROM Projeler WHERE ID = @ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ID", projeId);
                cmd.ExecuteNonQuery();
            }
        }


        private void LoadIletisimBilgileri()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM Iletisim";
                SqlCommand checkCmd = new SqlCommand(query, conn);
                int rowCount = (int)checkCmd.ExecuteScalar();

                // Eğer veri yoksa, ilk veriyi eklemek için bir INSERT sorgusu çalıştırabiliriz
                if (rowCount > 0)
                {
                    // Veriler varsa, mevcut veriyi al
                    string selectQuery = "SELECT TOP 1 Instagram, Mail, WhatsApp FROM Iletisim";
                    SqlCommand cmd = new SqlCommand(selectQuery, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtInstagram.Text = reader["Instagram"].ToString();
                        txtMail.Text = reader["Mail"].ToString();
                        txtWhatsApp.Text = reader["WhatsApp"].ToString();
                    }
                }
            }
        }

        protected void SaveIletisim(object sender, EventArgs e)
        {
            string instagram = txtInstagram.Text;
            string mail = txtMail.Text;
            string whatsapp = txtWhatsApp.Text;

            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Önce tabloyu kontrol et
                string checkQuery = "SELECT COUNT(*) FROM Iletisim";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                int rowCount = (int)checkCmd.ExecuteScalar();

                // Eğer hiç veri yoksa INSERT, varsa UPDATE yap
                if (rowCount == 0)
                {
                    string insertQuery = "INSERT INTO Iletisim (Instagram, Mail, WhatsApp) VALUES (@Instagram, @Mail, @WhatsApp)";
                    SqlCommand cmd = new SqlCommand(insertQuery, conn);
                    cmd.Parameters.AddWithValue("@Instagram", instagram);
                    cmd.Parameters.AddWithValue("@Mail", mail);
                    cmd.Parameters.AddWithValue("@WhatsApp", whatsapp);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    string updateQuery = "UPDATE Iletisim SET Instagram = @Instagram, Mail = @Mail, WhatsApp = @WhatsApp";
                    SqlCommand cmd = new SqlCommand(updateQuery, conn);
                    cmd.Parameters.AddWithValue("@Instagram", instagram);
                    cmd.Parameters.AddWithValue("@Mail", mail);
                    cmd.Parameters.AddWithValue("@WhatsApp", whatsapp);
                    cmd.ExecuteNonQuery();
                }
            }
        }
        private void LoadTalepler()
        {
            string connStr = ConfigurationManager.ConnectionStrings["nevitasarim"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT * FROM Talepler"; // Talepler tablosundan verileri alıyoruz
                    SqlCommand cmd = new SqlCommand(query, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    gvTalepler.DataSource = reader;  // Verileri GridView'a bağla
                    gvTalepler.DataBind();           // Verileri GridView'da göster
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Tasarım talepleri yüklenirken hata oluştu: " + ex.Message + "');</script>");
                }
            }

        }
    }
}