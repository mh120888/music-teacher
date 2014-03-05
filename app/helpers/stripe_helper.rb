module StripeHelper

  def email_for(payment)
    payment["card"]["name"]
  end

  def amount_for(payment)
    "$#{(payment["amount"] / 100.0)}"
  end

  def date_for(payment)
    DateTime.strptime(payment["created"].to_s,'%s').to_s[0..9]
  end

  def group_by_date(payments)
    group = {}
    payments["data"].each do |charge|
      date = DateTime.strptime(charge["created"].to_s, '%s').strftime("%B %e, %Y")
      if group[date]
        group[date] << charge
      else
        group[date] = [charge]
      end
    end
    group
  end

  def username(account)
    account.retrieve.display_name
  end

  def name_for(plan)
    plan["name"]
  end

  def description_for(plan)
    "$#{plan["amount"] / 100.0} each #{plan["interval"]}"
  end

  def subscribers_for(plan)
    Stripe::Customer.all.select do |cust|
      cust.subscriptions.data[0] && cust.subscriptions.data[0].plan.id == plan.id
    end
  end
end