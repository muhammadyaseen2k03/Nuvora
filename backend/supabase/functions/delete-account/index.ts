// Deletes the calling user's account and all of their cloud data.
//
// Account deletion needs the service-role key (auth.admin), which must never
// be shipped in the app, so it lives here, in a server-side function.
// All sync rows are removed automatically: sync_records.user_id references
// auth.users with ON DELETE CASCADE.
//
// Deploy: supabase functions deploy delete-account
// Secrets (set in the Supabase dashboard, never in the app):
//   SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY are provided to functions
//   automatically.
//
// NOT YET DEPLOYED OR TESTED by the repository author.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2.45.4";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, content-type, apikey",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return json({ error: "method_not_allowed" }, 405);

  const authHeader = req.headers.get("Authorization") ?? "";
  const token = authHeader.replace(/^Bearer\s+/i, "");
  if (!token) return json({ error: "unauthorized" }, 401);

  const url = Deno.env.get("SUPABASE_URL")!;
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const admin = createClient(url, serviceKey, {
    auth: { persistSession: false },
  });

  // Identify the caller from their own JWT; never trust a user id in the body.
  const { data: userData, error: userError } = await admin.auth.getUser(token);
  if (userError || !userData.user) return json({ error: "unauthorized" }, 401);

  const { error } = await admin.auth.admin.deleteUser(userData.user.id);
  if (error) return json({ error: "delete_failed" }, 500);
  return json({ ok: true }, 200);
});

function json(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}
