class LocalDatabaseStructure {
  //odoo_id INTEGER,
  static String carStructure = """
        car_id INTEGER PRIMARY KEY,
        car_name TEXT
        """;

  static String requestStructure = """
        id INTEGER PRIMARY KEY,
        product_car_id INTEGER,
        product_car_name TEXT, 
        requests_id INTEGER,  
        from_date TEXT,
        to_date TEXT,
        month_name INTEGER,
        source_path_id INTEGER,
        source_path_name TEXT,
        state TEXT,
        request_lines TEXT,
        driver_id INTEGER,
        amout_total REAL
        """;
//  FOREIGN KEY (carid) REFERENCES car(id),
//  FOREIGN KEY (source_shipping_path) REFERENCES car(id),
  static String sourcePathStructure = """
        source_path_id INTEGER PRIMARY KEY,
        source_path_name TEXT,
        product_car_id INTEGER,
        lines TEXT
        """;
  static String sourcePathLineStructure = """
        dest_id INTEGER PRIMARY KEY,
        dest_name TEXT,
        dest_price REAL
        """;
// id INTEGER PRIMARY KEY AUTOINCREMENT,
  static String customerStructure = """
      id INTEGER PRIMARY KEY AUTOINCREMENT,almirabi_2022_2023_app
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
        driver_id INTEGER PRIMARY KEY,
        driver_name TEXT,
        source_path_id INTEGER ,
        source_path_name TEXT,
        car_id INTEGER,
        car_name TEXT,
        lines TEXT,
        image TEXT
        """;

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
