using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LKS_Wilayah
{
    public partial class MasterPatient : Form
    {
        public MasterPatient()
        {
            InitializeComponent();
        }

        void tampilpasien()
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                string query = "SELECT name, phone_number, email, date_of_birth, address, gender, blood_type FROM patient";
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                dataGridView1.DataSource = dt;
            }

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dataGridView1.Rows[e.RowIndex];

                tbName.Text = row.Cells["name"].Value.ToString();
                tbPhone.Text = row.Cells["phone_number"].Value.ToString();
                tbEmail.Text = row.Cells["email"].Value.ToString();
                tbDateOfBirth.Text = row.Cells["date_of_birth"].Value.ToString();
                tbAddress.Text = row.Cells["address"].Value.ToString();
                tbGender.Text = row.Cells["gender"].Value.ToString();
                tbBlood.Text = row.Cells["blood_type"].Value.ToString();

            }
        }

        private void MasterPatient_Load(object sender, EventArgs e)
        {
            tampilpasien();
        }

        private void SrchInput_TextChanged(object sender, EventArgs e)
        {
            using(SqlConnection connection = koneksi.GetConn())
            {
                string query = "SELECT * FROM patient WHERE name LIKE @search OR phone_number LIKE @search OR email LIKE @search";
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                adapter.SelectCommand.Parameters.AddWithValue("@search", "%" + SrchInput.Text + "%");
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                dataGridView1.DataSource = dt;
            }
        }
    }
}
