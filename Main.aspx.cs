using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Main : System.Web.UI.Page
{
    protected void Page_PreInit(object sender, EventArgs e)
    {
        string theme;
        theme = (string)Session["theme"];
        if ((theme != null) && (theme.Length != 0))
        {
            Page.Theme = theme;
            themeddl.Text = theme;
        }
        else
        {
            Page.Theme = "Light";
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void calc_Click(object sender, EventArgs e)
    {
       // HttpCookie cook = new HttpCookie("Count");
        try
        {
            double num1 = Double.Parse(num1tb.Text);
            double num2 = Double.Parse(num2tb.Text);
            string op = opddl.SelectedItem.Value;
            double res = 0;
            if(op == "+")
            {
                res = num1 + num2;
            }else if(op == "-")
            {
                res = num1 - num2;
            }else if(op == "*")
            {
                res = num1 * num2;
            }else
            {
                res = num1 / num2;
            }
            reslb.Text = "Result : " + res.ToString();
            HttpCookie cookie = Request.Cookies["Count"];
            if(hiscbl.SelectedValue == "1")
            {
                String connectionString = @"Data Source = (localdb)\MSSQLlocalDB; Initial Catalog = Calculations; Integrated Security = True";
                string insertSQL = "INSERT INTO HISTORY (num1, num2, op, result)";
                insertSQL += "VALUES (@fn, @sn, @op, @result)";
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand(insertSQL, con);
                cmd.Parameters.AddWithValue("@fn", num1);
                cmd.Parameters.AddWithValue("@sn", num2);
                cmd.Parameters.AddWithValue("@op", opddl.SelectedValue);
                cmd.Parameters.AddWithValue("@result", res);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception err)
                {
                    reslb.Text = err.Message.ToString();
                }
            }
            
           
            

            if (cookie == null)
            {
                cookie = new HttpCookie("Count");
                cookie.Expires = DateTime.Now.AddHours(5);
                cookie.Values["cnt"] = "0";
            }
            else
            {
                cookie.Values["cnt"] = (int.Parse(cookie.Values["cnt"]) + 1) + "";
            }
            
            
            if (Request.Cookies["Count"] != null)
            {
                if (Request.Cookies["Count"]["cnt"] != null)
                {
                    cntlb.Text = "Total Calculations Done : " + Request.Cookies["Count"]["cnt"];
                }
            }
            Response.Cookies.Add(cookie);
        }
        catch(Exception x)
        {
            reslb.Text = x.Message.ToString();
        }
    }

    protected void hist_Click(object sender, EventArgs e)
    {
        SqlDataSource sds = new SqlDataSource();
        sds.ID = "sds1";
        this.Page.Controls.Add(sds);
        sds.ConnectionString = @"Data Source = (localdb)\MSSQLlocalDB; Initial Catalog = Calculations; Integrated Security = True";
        if(histrbl.SelectedValue == "5")
        {
            sds.SelectCommand = "SELECT TOP 5 num1, op, num2, result FROM History ORDER BY Id DESC";
        }
        else
        {
            sds.SelectCommand = "SELECT TOP 10 num1, op, num2, result FROM History ORDER BY Id DESC";
        }
       
        hist_grid.DataSource = sds;
        hist_grid.DataBind();
    }

    protected void themeddl_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["theme"] = themeddl.SelectedItem.Value;
        Server.Transfer(Request.FilePath);
    }
}