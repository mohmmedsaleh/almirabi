class LocalDatabaseStructure {
  //odoo_id INTEGER,
  static String productStructure = """
        id INTEGER PRIMARY KEY,
        product_id INTEGER,
        product_name TEXT,
        detailed_type TEXT,
        product_tmpl_id INTEGER,
        pos_available INTEGER,
        uom_id INTEGER,
        default_code TEXT,
        so_pos_categ_id INTEGER,
        barcode TEXT,
        unit_price REAL,
        currency TEXT,
        image TEXT,
        record_hash TEXT""";

  static String posCategoryStructure = """
        id INTEGER PRIMARY KEY,
        name TEXT""";

  static String productUnitStructure = """
        id INTEGER PRIMARY KEY,
        name TEXT""";

// id INTEGER PRIMARY KEY AUTOINCREMENT,
  static String customerStructure = """
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT,
      phone TEXT,
      image_1920 TEXT,
      vat TEXT,
      customer_rank INTEGER
      """;

// id INTEGER PRIMARY KEY AUTOINCREMENT,
  static String notificationStructure = """
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          subscription_detail_id INTEGER,
          ticket_reply TEXT,
          create_date TEXT,
          exception_details TEXT,
          stauts INTEGER
      """;
  static String userStructure = """
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT,
        pincode TEXT""";

    static String posSessionStructure = """
        id INTEGER PRIMARY KEY,
        pos_id INTEGER,
        user_id INTEGER,
        user_name TEXT,
        state TEXT,
        start_date TEXT,
        end_date TEXT,
        payment_session REAL,
        balance_opening REAL,
        last_end_date TEXT,
        last_balance_opening REAL
        """;


  //
  // static String itemHistoryStructure = """
  //     id INTEGER PRIMARY KEY AUTOINCREMENT,
  //     is_added INTEGER,
  //     type_name TEXT,
  //     product_id INTEGER,
  //     customer_id INTEGER,
  //     pos_category_id INTEGER,
  //     FOREIGN KEY (product_id) REFERENCES product(id),
  //     FOREIGN KEY (customer_id) REFERENCES customer(id),
  //     FOREIGN KEY (pos_category_id) REFERENCES poscategory(id)
  //     """;
}
