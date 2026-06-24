using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics.Eventing.Reader;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LKS_Wilayah
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            labelGreet.Text = "Welcome, " + session.username.Replace("_", " ");
        }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            this.Close();
            LoginForm loginForm = new LoginForm();
            loginForm.Show();
        }

        private void btnMasterDoctor_Click(object sender, EventArgs e)
        {
            MasterDoctor MD = new MasterDoctor();
            MD.Show();
        }

        private void btnMasterPatient_Click(object sender, EventArgs e)
        {
            MasterPatient MP = new MasterPatient();
            MP.Show();
        }

        private void btnManageMeeting_Click(object sender, EventArgs e)
        {
            ManageMeeting MM = new ManageMeeting();
            MM.Show();
        }
    }
}
