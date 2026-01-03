# 1️⃣ Overall Performance 

### 1. Sales vs Profit Scatter

**Observed**

* Nonlinear relationship
* Some high-sales, low-profit outliers

**Inference question**

> Is sales a statistically significant predictor of profit?

**Method**

* Linear regression:
  `profit ~ sales`
* Optional log-log version

**Why?**

* Establishes baseline elasticity
* Good “sanity check” regression early in the notebook

---

### 2. Top X% Orders vs Total Sales Contribution

**Observed**

* Strong Pareto concentration

**Inference question**

> Is revenue significantly concentrated beyond what uniform randomness would suggest?

**Method**

* No formal hypothesis test needed (descriptive Pareto is fine)

---

# 2️⃣ Geographic Performance 

### 3. Profit Margin by Region

**Observed**

* Regions differ materially in margin

**Inference question**

> Are regional margin differences statistically significant?

**Method**

* One-way ANOVA:
  `margin ~ region`
* Post-hoc Tukey if needed

**Why?**

* Strong justification: multiple groups, continuous outcome

---

### 4. Return Rate by Region / Market

**Observed**

* Clear variation across regions

**Inference question**

> Is return probability independent of region?

**Method**

* Chi-square test:
  `returned × region`
* Or logistic regression:
  `returned ~ region`

**Why?**

* Binary outcome → good use case
* High business relevance (risk geography)

---

### 5. Discount vs Profit by Region (faceted)

**Observed**

* Discount sensitivity differs by region

**Inference question**

> Does discount impact profit differently across regions?

**Method**

* Interaction regression:

```r
profit ~ discount * region
```

**Why?**

* Shows *heterogeneous effects*

---

# 3️⃣ Segment & Organizational Performance 

### 6. Profit Margin by Segment

**Observed**

* Segment-level margin differences

**Inference question**

> Are segment margins statistically different?

**Method**

* ANOVA:
  `margin ~ segment`

**Why?**

* Clean and interpretable question

---

### 7. Return Rate by Segment

**Observed**

* Segment differences in return rates

**Inference question**

> Does segment membership affect return probability?

**Method**

* Chi-square OR logistic regression:

```r
returned ~ segment
```

**Why?**

* Supports segmentation strategy discussion

---

### 8. Discount vs Profit by Segment

**Observed**

* Different slopes per segment

**Inference question**

> Does discounting erode profit differently across segments?

**Method**

* Interaction regression:

```r
profit ~ discount * segment
```

**Why?**

* Efficient applied regression data

---

### 9. Concentration: Top X% Products / Customers per Segment

**Observed**

* Segment-specific dependence on few products/customers

**Inference question**

> Are segments structurally more concentrated than others?

**Method**

* Descriptive only OR
* Compare Gini coefficients (optional)
---

# 4️⃣ Returns & Risk 

### 10. Returned vs Non-returned Profit per Order

**Observed**

* Returned orders clearly less profitable

**Inference question**

> Is mean profit per order lower for returned orders?

**Method**

* Welch t-test:

```r
profit ~ returned
```

**Why?**

* Clean hypothesis
* Strong causal intuition (even if not causal proof)

---

### 11. Discount vs Return Probability

**Observed**

* Return rate increases with discount

**Inference question**

> Does discount increase return probability?

**Method**

* Logistic regression:

```r
returned ~ discount
```

**Why?**

* Strong inferential candidates
* Clear managerial takeaway

---

### 12. Return Rate by Discount Bucket

**Observed**

* Monotonic-ish increase

**Inference question**

> Are return rates significantly different across discount buckets?

**Method**

* Chi-square test
* OR logistic regression with factor (discount_bucket)

**Why?**

* Reinforces discount-risk link without overfitting

---

### 13. Profit per Discount Bucket

**Observed**

* Profit erosion at high discounts

**Inference question**

> Is mean profit significantly different across discount levels?

**Method**

* ANOVA:

```r
profit ~ discount_bucket
```

---

### 14. Return Rate vs Product Margin

**Observed**

* Low-margin products have higher returns

**Inference question**

> Is return probability related to product margin?

**Method**

* Logistic regression:

```r
returned ~ margin
```

**Why?**

* Connects pricing, cost structure, and risk

---

# 5️⃣ Temporal Trends 

### 15. Pre/Post 2013 Performance

**Observed**

* Step change in sales/profit

**Inference question**

> Was there a statistically significant change after 2013?

**Method**

* t-test OR regression:

```r
profit ~ post_2013
```

**Why?**

* Quasi-experimental framing helpful in both micro and macro economic settings

---

### 16. Year-over-Year Growth

**Observed**

* Strong growth years vs weaker ones

**Inference question**

> Is growth accelerating or decelerating over time?

**Method**

* Trend regression:

```r
log(sales) ~ year
```

**Why?**

* Explains long-term trajectory

---

### 17. Return Rate Over Time

**Observed**

* Time variation in return rate

**Inference question**

> Is return risk increasing over time?

**Method**

* Logistic regression with time:

```r
returned ~ year
```

---

### 18. Discount Intensity Over Time

**Observed**

* Increasing discount usage

**Inference question**

> Is discount intensity trending upward?

**Method**

* Linear regression:

```r
discount ~ year
```

---

# Final Verdict:

**Must-have**

1. `returned ~ discount` (logistic)
2. `profit ~ returned` (t-test)
3. `profit ~ discount * segment`
4. `margin ~ region` (ANOVA)
5. `profit ~ post_2013`
6. `returned ~ segment`

**Optional**

* `returned ~ margin`
* `profit ~ discount * region`

