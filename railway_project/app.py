from flask import Flask, jsonify, request, render_template
import sqlite3
from pathlib import Path

app = Flask(__name__)

BASE   = Path(__file__).parent
SCHEMA = BASE / "schema.sql"
SEED   = BASE / "seed.sql"
DB     = BASE / "railway.db"

# ── DB Helpers ────────────────────────────────────────────────────────────────

def get_conn():
    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn

def init_db():
    conn = get_conn()
    with conn:
        # 1. Create tables from schema
        conn.executescript(SCHEMA.read_text())
        
        # 2. Check if the database is empty. If yes, inject the seed data.
        cur = conn.execute("SELECT COUNT(*) FROM zones")
        if cur.fetchone()[0] == 0:
            print("🚂 Empty database detected. Injecting seed data...")
            conn.executescript(SEED.read_text())
    conn.close()

# ── Frontend Route ────────────────────────────────────────────────────────────

@app.route("/")
def index():
    return render_template("index.html")

# ── Universal SQL API (For local educational use) ─────────────────────────────

@app.route("/api/sql", methods=["POST"])
def api_sql():
    data = request.json
    sql = data.get("sql", "")
    params = data.get("params", [])
    is_write = data.get("is_write", False)

    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute(sql, params)

        # If it's an INSERT/UPDATE/DELETE statement
        if is_write:
            conn.commit()
            conn.close()
            return jsonify({"success": True})
        
        # If it's a SELECT statement
        else:
            rows = [dict(row) for row in cur.fetchall()]
            conn.close()
            return jsonify({"success": True, "data": rows})
            
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 400

if __name__ == "__main__":
    init_db()
    print("\n✅ Railway Backend Running at http://127.0.0.1:5000\n")
    app.run(debug=True, port=5000)