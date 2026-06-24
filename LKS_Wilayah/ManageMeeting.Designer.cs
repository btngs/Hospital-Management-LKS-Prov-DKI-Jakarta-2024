namespace LKS_Wilayah
{
    partial class ManageMeeting
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
            this.dtMeeting = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.dtRecords = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dtMeeting)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtRecords)).BeginInit();
            this.SuspendLayout();
            // 
            // dtMeeting
            // 
            this.dtMeeting.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dtMeeting.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dtMeeting.Location = new System.Drawing.Point(53, 70);
            this.dtMeeting.Name = "dtMeeting";
            this.dtMeeting.Size = new System.Drawing.Size(696, 238);
            this.dtMeeting.TabIndex = 22;
            this.dtMeeting.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dtMeeting_CellContentClick);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(313, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(187, 25);
            this.label1.TabIndex = 21;
            this.label1.Text = "Manage Meeting";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(50, 330);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(83, 13);
            this.label2.TabIndex = 23;
            this.label2.Text = "Patient Records";
            // 
            // dtRecords
            // 
            this.dtRecords.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dtRecords.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dtRecords.Location = new System.Drawing.Point(53, 355);
            this.dtRecords.Name = "dtRecords";
            this.dtRecords.Size = new System.Drawing.Size(696, 162);
            this.dtRecords.TabIndex = 24;
            // 
            // ManageMeeting
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 602);
            this.Controls.Add(this.dtRecords);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dtMeeting);
            this.Controls.Add(this.label1);
            this.Name = "ManageMeeting";
            this.Text = "ManageMeeting";
            this.Load += new System.EventHandler(this.ManageMeeting_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dtMeeting)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dtRecords)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dtMeeting;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DataGridView dtRecords;
    }
}