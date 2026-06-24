namespace LKS_Wilayah
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.labelGreet = new System.Windows.Forms.Label();
            this.btnICD11 = new System.Windows.Forms.Button();
            this.btnMasterDoctor = new System.Windows.Forms.Button();
            this.btnMasterPatient = new System.Windows.Forms.Button();
            this.btnNewMeeting = new System.Windows.Forms.Button();
            this.btnManageMeeting = new System.Windows.Forms.Button();
            this.btnLogout = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelGreet
            // 
            this.labelGreet.AutoSize = true;
            this.labelGreet.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelGreet.Location = new System.Drawing.Point(43, 25);
            this.labelGreet.Name = "labelGreet";
            this.labelGreet.Size = new System.Drawing.Size(0, 24);
            this.labelGreet.TabIndex = 0;
            // 
            // btnICD11
            // 
            this.btnICD11.Location = new System.Drawing.Point(183, 80);
            this.btnICD11.Name = "btnICD11";
            this.btnICD11.Size = new System.Drawing.Size(169, 27);
            this.btnICD11.TabIndex = 1;
            this.btnICD11.Text = "ICD-11";
            this.btnICD11.UseVisualStyleBackColor = true;
            // 
            // btnMasterDoctor
            // 
            this.btnMasterDoctor.Location = new System.Drawing.Point(183, 113);
            this.btnMasterDoctor.Name = "btnMasterDoctor";
            this.btnMasterDoctor.Size = new System.Drawing.Size(169, 27);
            this.btnMasterDoctor.TabIndex = 2;
            this.btnMasterDoctor.Text = "Master Doctor";
            this.btnMasterDoctor.UseVisualStyleBackColor = true;
            this.btnMasterDoctor.Click += new System.EventHandler(this.btnMasterDoctor_Click);
            // 
            // btnMasterPatient
            // 
            this.btnMasterPatient.Location = new System.Drawing.Point(183, 146);
            this.btnMasterPatient.Name = "btnMasterPatient";
            this.btnMasterPatient.Size = new System.Drawing.Size(169, 27);
            this.btnMasterPatient.TabIndex = 3;
            this.btnMasterPatient.Text = "Master Patient";
            this.btnMasterPatient.UseVisualStyleBackColor = true;
            this.btnMasterPatient.Click += new System.EventHandler(this.btnMasterPatient_Click);
            // 
            // btnNewMeeting
            // 
            this.btnNewMeeting.Location = new System.Drawing.Point(183, 179);
            this.btnNewMeeting.Name = "btnNewMeeting";
            this.btnNewMeeting.Size = new System.Drawing.Size(169, 27);
            this.btnNewMeeting.TabIndex = 4;
            this.btnNewMeeting.Text = "New Meeting";
            this.btnNewMeeting.UseVisualStyleBackColor = true;
            // 
            // btnManageMeeting
            // 
            this.btnManageMeeting.Location = new System.Drawing.Point(183, 212);
            this.btnManageMeeting.Name = "btnManageMeeting";
            this.btnManageMeeting.Size = new System.Drawing.Size(169, 27);
            this.btnManageMeeting.TabIndex = 5;
            this.btnManageMeeting.Text = "Manage Meeting";
            this.btnManageMeeting.UseVisualStyleBackColor = true;
            this.btnManageMeeting.Click += new System.EventHandler(this.btnManageMeeting_Click);
            // 
            // btnLogout
            // 
            this.btnLogout.Location = new System.Drawing.Point(442, 28);
            this.btnLogout.Name = "btnLogout";
            this.btnLogout.Size = new System.Drawing.Size(66, 23);
            this.btnLogout.TabIndex = 6;
            this.btnLogout.Text = "Logout";
            this.btnLogout.UseVisualStyleBackColor = true;
            this.btnLogout.Click += new System.EventHandler(this.btnLogout_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(538, 278);
            this.Controls.Add(this.btnLogout);
            this.Controls.Add(this.btnManageMeeting);
            this.Controls.Add(this.btnNewMeeting);
            this.Controls.Add(this.btnMasterPatient);
            this.Controls.Add(this.btnMasterDoctor);
            this.Controls.Add(this.btnICD11);
            this.Controls.Add(this.labelGreet);
            this.Name = "MainForm";
            this.Text = "MainForm";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelGreet;
        private System.Windows.Forms.Button btnICD11;
        private System.Windows.Forms.Button btnMasterDoctor;
        private System.Windows.Forms.Button btnMasterPatient;
        private System.Windows.Forms.Button btnNewMeeting;
        private System.Windows.Forms.Button btnManageMeeting;
        private System.Windows.Forms.Button btnLogout;
    }
}