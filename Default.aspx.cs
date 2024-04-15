using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = "Server=localhost\\SQLEXPRESS;Database=db_ECommerceShop;Trusted_Connection=True;TrustServerCertificate=true;";
            string sql = "SELECT * FROM Products WHERE isDeleted = 0"; // Replace with your actual query
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sql, connection);


                //// Create a DataTable to store the results
                //DataTable dataTable = new DataTable();
                //dataTable.Load(command.ExecuteReader()); // Load data into DataTable

                //// Bind the DataTable to the GridView
                //ProductsGridView.DataSource = dataTable;
                //ProductsGridView.DataBind();

                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    // Create a product card HTML string dynamically
                    string productId = reader["ProductId"].ToString();
                    string imageUrl = reader["image_url"].ToString();
                    string productName = reader["Name"].ToString();
                    //string description = reader["Description"].ToString();
                    string lastPrice = reader["LastPrice"].ToString();
                    string price = reader["Price"].ToString();

                    string productCardHtml = $@"
            <div class="" relative m-10 flex w-full max-w-xs flex-col overflow-hidden rounded-lg border border-gray-100 bg-white shadow-md"">
              <a class=""relative mx-3 mt-3 flex h-44 overflow-hidden rounded-xl"" href=""/ProductDetails.aspx?productId={productId}"">
                <img class=""object-cover w-full"" src=""{imageUrl}"" alt=""product image"" />
              </a>
              <div class=""mt-4 px-2 pb-5"">
                <a  href=""/ProductDetails.aspx?productId={productId}"">
                  <h5 class=""text-lg text-blue-500 font-bold "">{productName}</h5>
                </a>
                <div class=""mt-2 mb-5 flex items-center justify-between"">
                  <p>
                    <span class=""text-xl font-medium text-red-400"">{lastPrice}</span>
                    <span class=""text-sm text-slate-900 line-through"">{price}</span>
                  </p>
                </div>
                <a href=""#"" class=""flex p-2 items-center justify-center rounded-md bg-gradient-to-r
            from-sky-400 to-blue-500 
            px-5 text-center text-sm font-medium text-white hover:bg-gray-700 
                focus:outline-none focus:ring-4 focus:ring-blue-300"">
                  <svg xmlns=""http://www.w3.org/2000/svg"" class=""mr-2 h-6 w-6"" fill=""none"" viewBox=""0 0 24 24"" stroke=""currentColor"" stroke-width=""2"">
                    <path stroke-linecap=""round"" stroke-linejoin=""round"" d=""M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"" />
                  </svg>
                  Thêm vào giỏ </a
                >
              </div>
            </div>
               ";



                    // Add the product card HTML to a placeholder control or directly to the page
                    ProductsPlaceholder.Controls.Add(new LiteralControl(productCardHtml));
                }

                reader.Close();
            } // Make sure to close the SqlConnection block

        }
    }
}