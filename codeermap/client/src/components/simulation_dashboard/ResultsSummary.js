import React from "react";
import { Sun, BatteryCharging, PiggyBank } from "lucide-react";

const ResultsSummary = ({ displayResults }) => {
  const cardsData = [
    {
      title: "Estimated Savings",
      value: `${displayResults.fifteenDay.savings} €`,
      icon: <PiggyBank size={140} color="#ff69b4" />,
      description: "Energy saved in the last 15 days",
      progress: (displayResults.fifteenDay.savings / 1000) * 100,
    },
    {
      title: "Total Energy Usage",
      value: `${displayResults.fifteenDay.energyUsage} kWh`,
      icon: <BatteryCharging size={140} color="#007bff" />,
      description: "Total energy consumed in the last 15 days",
      progress: (displayResults.fifteenDay.energyUsage / 2000) * 100,
    },
    {
      title: "Solar Panel Output",
      value: `${displayResults.fifteenDay.panelOutput} kWh`,
      icon: <Sun size={140} color="#ffc107" />,
      description: "Energy generated by solar panels in 15 days",
      progress: (displayResults.fifteenDay.panelOutput / 1500) * 100,
    },
  ];

  return (
    <div className="card-container">
      {cardsData.map((card, index) => (
        <Card
          key={index}
          title={card.title}
          value={card.value}
          description={card.description}
          icon={card.icon}
        />
      ))}
    </div>
  );
};

function Card({ title, value, icon, description, progress }) {
  return (
    <div className="card">
      <div className="card-content">
        <div className="card-text">
          <h3>{title}</h3>
          <h2>{value}</h2>
          <p>{description}</p>
          {progress !== undefined && (
            <div className="progress-bar">
              <div
                className="progress-bar-fill"
                style={{ width: `${progress}%`, backgroundColor: "#28a745" }}
              ></div>
            </div>
          )}
        </div>
        <div className="icon-container">{icon}</div>
      </div>
    </div>
  );
}

export default ResultsSummary;
