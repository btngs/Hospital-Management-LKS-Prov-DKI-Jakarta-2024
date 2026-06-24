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
    public partial class MasterDoctor : Form
    {
        private bool isLoadingCategory;

        public MasterDoctor()
        {
            InitializeComponent();
        }

        private void MasterDoctor_Load(object sender, EventArgs e)
        {
            tampilcategory();
            tampildata();
        }

        void tampildata(int? categoryId = null)
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                try
                {
                    connection.Open();
                    string query = @"SELECT 
                        d.name,
                        d.phone_number,
                        d.email,
                        d.city_of_birth,
                        d.date_of_birth,
                        d.address,
                        d.gender,
                        d.assigned_room,
                        dc.category
                        FROM doctor d
                        LEFT JOIN doctor_category dc 
                        ON d.doctor_category_id = dc.id";

                    if (categoryId.HasValue)
                    {
                        query += " WHERE d.doctor_category_id = @category";
                    }

                    SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                    if (categoryId.HasValue)
                    {
                        adapter.SelectCommand.Parameters.AddWithValue("@category", categoryId.Value);
                    }

                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    dataGridView1.DataSource = dataTable;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: " + ex.Message);
                }
            }
        }

        void tampilcategory()
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                try
                {
                    isLoadingCategory = true;
                    connection.Open();
                    string query = "SELECT id, category FROM doctor_category";
                    SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    DataRow allCategoryRow = dataTable.NewRow();
                    allCategoryRow["id"] = 0;
                    allCategoryRow["category"] = "All Categories";
                    dataTable.Rows.InsertAt(allCategoryRow, 0);

                    CatSelect.DataSource = dataTable;
                    CatSelect.DisplayMember = "category";
                    CatSelect.ValueMember = "id";
                    CatSelect.SelectedValue = 0;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Error: " + ex.Message);
                }
                finally
                {
                    isLoadingCategory = false;
                }
            }
        }

        private void CatSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (isLoadingCategory || CatSelect.SelectedValue == null) return;

            int selectedCategoryId;

            if (CatSelect.SelectedValue is DataRowView dataRowView)
            {
                selectedCategoryId = Convert.ToInt32(dataRowView["id"]);
            }
            else
            {
                selectedCategoryId = Convert.ToInt32(CatSelect.SelectedValue);
            }

            if (selectedCategoryId == 0)
            {
                tampildata();
                return;
            }

            tampildata(selectedCategoryId);
        }

        private void SrchInput_TextChanged(object sender, EventArgs e)
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                string query = "SELECT * FROM doctor WHERE name LIKE @name";
                SqlDataAdapter DA = new SqlDataAdapter(query, connection);
                DA.SelectCommand.Parameters.AddWithValue("@name", "%" + SrchInput.Text + "%");
                DataTable dt = new DataTable();
                DA.Fill(dt);
                dataGridView1.DataSource = dt;
            }
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.RowIndex >= 0)
            {
                DataGridViewRow row = dataGridView1.Rows[e.RowIndex];

                tbName.Text = row.Cells["name"].Value.ToString();
                tbPhone.Text = row.Cells["phone_number"].Value.ToString();
                tbEmail.Text = row.Cells["email"].Value.ToString();
                tbDateOfBirth.Text = row.Cells["date_of_birth"].Value.ToString();
                tbCategory.Text = row.Cells["category"].Value.ToString();
                tbAddress.Text = row.Cells["address"].Value.ToString();
                tbGender.Text = row.Cells["gender"].Value.ToString();
                tbRoom.Text = row.Cells["assigned_room"].Value.ToString();
            }
        }
    }
}
