using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LKS_Wilayah
{
    public static class koneksi
    {
        public const string DatabaseName = "LKS_Wilayah";
        private static string ConnString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=" + DatabaseName + @";Integrated Security=True;TrustServerCertificate=True";
        public static string MasterConnString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;TrustServerCertificate=True";

        public static SqlConnection GetConn()
        {
            return new SqlConnection(ConnString);
        }
    }
    public static class session
    {
        public static string username;
        public static bool isLoggedIn;
    }
}
