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
    public partial class ManageMeeting : Form
    {
        public ManageMeeting()
        {
            InitializeComponent();
        }

        void tampilmeeting()
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                connection.Open();
                string query = @"SELECT 
                                 meeting.id,
                                 meeting.date,
                                 patient.name AS patient_name,
                                 doctor.name AS doctor_name,
                                 doctor_category.category,
                                 meeting.queue_number,
                                 meeting.patient_id
                              FROM meeting
                              LEFT JOIN doctor ON doctor.id = meeting.doctor_id
                              LEFT JOIN doctor_category ON doctor.doctor_category_id = doctor_category.id
                              LEFT JOIN patient ON meeting.patient_id = patient.id";
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                dtMeeting.DataSource = dt;
            }
        }

        private void ManageMeeting_Load(object sender, EventArgs e)
        {
            tampilmeeting();
        }

        private void dtMeeting_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0) 
            {
                if (dtMeeting.Rows[e.RowIndex].Cells["patient_id"].Value != null)
                {
                    int patientId = Convert.ToInt32(dtMeeting.Rows[e.RowIndex].Cells["patient_id"].Value);
                    tampilRecords(patientId);
                }
            }
        }

        void tampilRecords(int patientId)
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                connection.Open();
                try
                {
                    string query = "SELECT notes FROM patient_record WHERE patient_id = @id";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@id", patientId);
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    dtRecords.DataSource = dt;
                }
                catch(Exception ex) 
                { 
                    MessageBox.Show("Error: " + ex.Message);
                }
            }
        }
    }
}
