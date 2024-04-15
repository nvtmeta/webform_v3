using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Check if productId query string parameter exists
                if (!string.IsNullOrEmpty(Request.QueryString["productId"]))
                {
                    // Get productId from query string
                    string productId = Request.QueryString["productId"];

                    // Fetch product details from database using productId
                    // Replace the following code with your database access logic
                    string connectionString = "Server=localhost\\SQLEXPRESS;Database=db_ECommerceShop;Trusted_Connection=True;TrustServerCertificate=true;";
                    string sql = "SELECT * FROM Products WHERE isDeleted = 0 and ProductId=@ProductId"; // Replace with your actual query

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand(sql, connection))
                        {
                            // Add productId as a parameter
                            command.Parameters.AddWithValue("@ProductId", productId);
                            connection.Open();

                            SqlDataReader reader = command.ExecuteReader();

                            if (reader.Read())
                            {
                                string imageUrl = reader["image_url"].ToString();
                                string productName = reader["Name"].ToString();
                              string description = reader["Description"].ToString();
                                string lastPrice = reader["LastPrice"].ToString();
                                string price = reader["Price"].ToString();

                                string productDetailHtml = $@"
        <div class='container m-3 '>
            <h1 class='text-3xl font-semibold text-center mb-8'>Product Details</h1>
            <div class='flex justify-center items-center mb-8'>
                <img src='{imageUrl}' alt='Product Image' class='w-64 h-64 object-cover rounded-lg shadow-lg'>
            </div>
            <div class='text-center mb-8'>
                <h2 class='text-2xl font-bold text-gray-800'>{productName}</h2>
            </div>
            <div class='text-center mb-8'>
                <p class='text-lg text-gray-700'>{description}</p>
            </div>
            <div class='text-center mb-8'>
                <p class='text-xl font-semibold text-red-400'>{lastPrice}</p>
                <p class='text-sm text-slate-900 line-through'>{price}</p>
            </div>
            <div class='text-center mb-8'>
                <a href='#' class='inline-block bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600'>Add to Cart</a>
            </div>
        </div>";

                                ProductDetailLiteral.Text = productDetailHtml;
                            }
                            else
                            {
                                // Product not found, handle accordingly (e.g., display error message)
                            }

                            reader.Close();
                        }
                    }
                }
                else
                {
                    // productId query string parameter is missing, handle accordingly
                }
            }
        }
    }
}