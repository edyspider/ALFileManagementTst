/// <summary>
/// XmlPort MyXmlport (ID 50100).
/// </summary>
xmlport 50100 MyXmlport
{
    schema
    {
        textelement(NodeName1)
        {
            tableelement(NodeCustomer; Customer)
            {
                fieldattribute(NodeCustNo; NodeCustomer."No.")
                {

                }
                fieldattribute(NodeCustName; NodeCustomer.Name)
                {

                }
            }
        }
    }
}