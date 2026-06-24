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

        private static string ConnString = @"Data Source=(localdb)\MSSQLLocalDb;Initial Catalog = DESKTOP_XX; Integrated Security = True; TrustServerCertificate=True";

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
