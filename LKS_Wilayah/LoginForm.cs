using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LKS_Wilayah
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
            textBox2.UseSystemPasswordChar = true;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        public static string HashPassword(string password)
        {
            using (SHA512 sha512 = SHA512.Create())
            {
                byte[] bytes = sha512.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(bytes).Replace("-", "").ToLower();
            }
        }

        private void BtnSubmit_Click(object sender, EventArgs e)
        {
            using(SqlConnection connection = koneksi.GetConn())
            {
                try
                {
                    connection.Open();
                    string query = "SELECT * FROM [user] WHERE username = @username AND password = @password";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@username", textBox1.Text);
                    command.Parameters.AddWithValue("@password", HashPassword(textBox2.Text));

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            session.username = reader["username"].ToString();
                            session.isLoggedIn = true;
                        }
                        this.Hide();
                        MainForm mainForm = new MainForm();
                        mainForm.ShowDialog();
                        this.Close();
                    }
                    else
                    {
                        MessageBox.Show("Login Gagal! Periksa username dan password Anda.", "", MessageBoxButtons.OK);
                    }
                }
                catch (Exception ex) 
                { 
                    MessageBox.Show("Terjadi kesalahan: " + ex.Message, "", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void PasswordToggle_CheckedChanged(object sender, EventArgs e)
        {
            if (PasswordToggle.Checked)
            {
                textBox2.UseSystemPasswordChar = false;
            }
            else 
            { 
                textBox2.UseSystemPasswordChar = true;
            }
        }
    }
}
