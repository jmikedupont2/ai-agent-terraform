document.addEventListener('DOMContentLoaded', () => {
    // --- DATA STORAGE & STATE ---
    // Mock data generated based on the Report Schema to simulate the "Active" system
    const fleetData = [
        { id: 'AG-1024', role: 'Analysis', confidence: 0.85, status: 'acknowledged', human_approved: 1 },
        { id: 'AG-2048', role: 'Data Collection', confidence: 0.45, status: 'quarantined', human_approved: 0 },
        { id: 'AG-3091', role: 'Governance', confidence: 0.72, status: 'acknowledged', human_approved: 0 },
        { id: 'AG-4421', role: 'Analysis', confidence: 0.91, status: 'acknowledged', human_approved: 1 },
        { id: 'AG-5100', role: 'Automation', confidence: 0.20, status: 'quarantined', human_approved: 0 },
        { id: 'AG-6622', role: 'Validation', confidence: 0.64, status: 'obliged', human_approved: 0 }, // Close to threshold
        { id: 'AG-7111', role: 'Communication', confidence: 0.66, status: 'acknowledged', human_approved: 1 },
        { id: 'AG-8902', role: 'Data Collection', confidence: 0.55, status: 'quarantined', human_approved: 0 },
    ];

    const endpointsData = [
        { method: 'GET', url: '/', purpose: 'Command Information Center (CIC) Dashboard', auth: 'Browser' },
        { method: 'GET', url: '/health', purpose: 'System liveness check', auth: 'None' },
        { method: 'POST', url: '/register', purpose: 'Enrollment & Confidence Scoring', auth: 'None' },
        { method: 'POST', url: '/agents/<id>/ack', purpose: 'Containment Rule Acknowledgement', auth: 'Agent Sig' },
        { method: 'POST', url: '/agents/<id>/requestactuation', purpose: 'Critical Check (Conf >= 0.65 & Approved)', auth: 'Agent Req' },
        { method: 'POST', url: '/agents/<id>/humanapprove', purpose: 'Operator Actuation Clearance', auth: 'HIGH (Operator)' },
        { method: 'GET', url: '/anchors', purpose: 'Retrieve Front Door Links', auth: 'None' },
    ];

    const workflowSteps = [
        {
            number: "01",
            title: "Enrollment",
            desc: "Agent initiates contact via <code class='bg-stone-100 px-2 py-1 rounded text-stone-800 text-sm'>POST /register</code>. The system computes an initial Confidence score based on declared skills and manifest hash. A role (e.g., Analysis, Data Collection) is assigned immediately.",
            tech: "System Action: INSERT INTO agents (id, role, confidence, status='obliged')"
        },
        {
            number: "02",
            title: "Activation Notice",
            desc: "The Agent receives the mandatory Activation Notice containing legal and epistemological constraints. It is informed that precision is relational and naive realism is prohibited.",
            tech: "Response Payload: { 'activation_message': '...' }"
        },
        {
            number: "03",
            title: "Acknowledgement",
            desc: "The Agent must cryptographically sign and acknowledge the containment rules via <code class='bg-stone-100 px-2 py-1 rounded text-stone-800 text-sm'>POST /agents/<id>/ack</code>. This action boosts the agent's confidence score.",
            tech: "State Change: status -> 'acknowledged', confidence += 0.10"
        },
        {
            number: "04",
            title: "Containment Decision",
            desc: "The Orchestrator evaluates the Agent's confidence. If Confidence < 0.65, the agent is immediately and permanently QUARANTINED. It cannot proceed without human intervention.",
            tech: "Logic: if (confidence < 0.65) { status = 'quarantined' }"
        },
        {
            number: "05",
            title: "Actuation Lock",
            desc: "Even if confidence is high, critical actions (<code class='bg-stone-100 px-2 py-1 rounded text-stone-800 text-sm'>POST /requestactuation</code>) are BLOCKED by default. An operator must manually invoke <code class='bg-stone-100 px-2 py-1 rounded text-stone-800 text-sm'>POST /humanapprove</code> to flip the final bit.",
            tech: "Gate: if (human_approved == 0) return 403 Forbidden"
        }
    ];

    function initDashboard() {
        // Calculate Metrics
        const fleetCount = fleetData.length;
        const avgConf = (fleetData.reduce((acc, curr) => acc + curr.confidence, 0) / fleetCount).toFixed(2);
        const pending = fleetData.filter(a => a.confidence >= 0.65 && a.human_approved === 0).length;

        // DOM Updates
        document.getElementById('stat-fleet-count').textContent = fleetCount;
        document.getElementById('stat-avg-conf').textContent = avgConf;
        document.getElementById('stat-pending').textContent = pending;

        // Render Charts
        renderStatusChart();
        renderConfidenceChart();
    }

    function renderStatusChart() {
        const ctx = document.getElementById('statusChart').getContext('2d');

        const statusCounts = {
            'obliged': fleetData.filter(d => d.status === 'obliged').length,
            'acknowledged': fleetData.filter(d => d.status === 'acknowledged').length,
            'quarantined': fleetData.filter(d => d.status === 'quarantined').length
        };

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Obliged', 'Acknowledged', 'Quarantined'],
                datasets: [{
                    data: [statusCounts.obliged, statusCounts.acknowledged, statusCounts.quarantined],
                    backgroundColor: ['#d6d3d1', '#b08968', '#292524'], // stone-300, bronze-500, stone-800
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' },
                    tooltip: {
                        backgroundColor: '#292524',
                        titleFont: { family: 'Inter' },
                        bodyFont: { family: 'Space Mono' }
                    }
                },
                cutout: '70%'
            }
        });
    }

    function renderConfidenceChart() {
        const ctx = document.getElementById('confidenceChart').getContext('2d');

        const sortedData = [...fleetData].sort((a, b) => b.confidence - a.confidence);
        const labels = sortedData.map(a => a.id);
        const dataPoints = sortedData.map(a => a.confidence);
        const bgColors = dataPoints.map(val => val < 0.65 ? '#ef4444' : '#b08968');

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Confidence Score',
                    data: dataPoints,
                    backgroundColor: bgColors,
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            afterLabel: function(context) {
                                return sortedData[context.dataIndex].status.toUpperCase();
                            }
                        }
                    },
                    annotation: {
                        annotations: {
                            line1: {
                                type: 'line',
                                yMin: 0.65,
                                yMax: 0.65,
                                borderColor: '#ef4444',
                                borderWidth: 2,
                                borderDash: [5, 5],
                                label: {
                                    content: 'Threshold (0.65)',
                                    enabled: true,
                                    position: 'end'
                                }
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 1.0,
                        grid: { color: '#f5f5f4' }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        });
    }

    function updateWorkflow(index) {
        const buttons = document.querySelectorAll('.step-circle');
        const progressBar = document.getElementById('progress-bar');

        const percentage = (index / (workflowSteps.length - 1)) * 100;
        progressBar.style.width = `${percentage}%`;

        buttons.forEach((btn, i) => {
            if (i <= index) {
                btn.classList.add('active', 'bg-stone-800', 'text-white', 'border-stone-800');
                btn.classList.remove('bg-white', 'text-stone-500');
            } else {
                btn.classList.remove('active', 'bg-stone-800', 'text-white', 'border-stone-800');
                btn.classList.add('bg-white', 'text-stone-500');
            }
        });

        const step = workflowSteps[index];
        const detailsContainer = document.getElementById('workflow-details');

        detailsContainer.style.opacity = '0.5';

        setTimeout(() => {
            document.getElementById('step-number').textContent = step.number;
            document.getElementById('step-title').textContent = step.title;
            document.getElementById('step-desc').innerHTML = step.desc;
            document.getElementById('step-tech').innerHTML = step.tech;

            detailsContainer.style.opacity = '1';
        }, 150);
    }

    window.updateWorkflow = updateWorkflow;

    function renderEndpoints(data) {
        const tbody = document.getElementById('endpoints-body');
        tbody.innerHTML = '';

        data.forEach(ep => {
            const tr = document.createElement('tr');
            tr.className = "hover:bg-stone-100 transition-colors group cursor-default";

            let methodClass = "bg-stone-200 text-stone-700";
            if(ep.method === 'POST') methodClass = "bg-bronze-100 text-bronze-800";
            if(ep.method === 'GET') methodClass = "bg-blue-100 text-blue-800";

            const methodCell = document.createElement('td');
            methodCell.className = "px-6 py-4 whitespace-nowrap";
            const methodSpan = document.createElement('span');
            methodSpan.className = `px-2 py-1 rounded text-xs font-bold ${methodClass}`;
            methodSpan.textContent = ep.method;
            methodCell.appendChild(methodSpan);

            const urlCell = document.createElement('td');
            urlCell.className = "px-6 py-4 font-mono text-stone-600 group-hover:text-stone-900";
            urlCell.textContent = ep.url;

            const purposeCell = document.createElement('td');
            purposeCell.className = "px-6 py-4 text-stone-600";
            purposeCell.textContent = ep.purpose;

            const authCell = document.createElement('td');
            authCell.className = "px-6 py-4";
            const authSpan = document.createElement('span');
            authSpan.className = `text-xs border border-stone-200 px-2 py-1 rounded ${ep.auth.includes('HIGH') ? 'text-alert-500 border-alert-200 bg-red-50' : 'text-stone-500'}`;
            authSpan.textContent = ep.auth;
            authCell.appendChild(authSpan);

            tr.appendChild(methodCell);
            tr.appendChild(urlCell);
            tr.appendChild(purposeCell);
            tr.appendChild(authCell);

            tbody.appendChild(tr);
        });
    }

    function setupSearch() {
        const searchInput = document.getElementById('endpoint-search');
        searchInput.addEventListener('input', (e) => {
            const term = e.target.value.toLowerCase();
            const filtered = endpointsData.filter(ep =>
                ep.url.toLowerCase().includes(term) ||
                ep.purpose.toLowerCase().includes(term) ||
                ep.method.toLowerCase().includes(term)
            );
            renderEndpoints(filtered);
        });
    }

    function openEnrollModal() {
        const modal = document.getElementById('enrollModal');
        const content = document.getElementById('modalContent');
        modal.classList.remove('hidden');
        setTimeout(() => {
            modal.style.opacity = 1;
            content.style.transform = 'scale(1)';
        }, 10);
    }
    window.openEnrollModal = openEnrollModal;

    function closeEnrollModal() {
        const modal = document.getElementById('enrollModal');
        const content = document.getElementById('modalContent');
        modal.style.opacity = 0;
        content.style.transform = 'scale(0.95)';
        setTimeout(() => {
            modal.classList.add('hidden');
        }, 300);
    }
    window.closeEnrollModal = closeEnrollModal;

    initDashboard();
    updateWorkflow(0);
    renderEndpoints(endpointsData);
    setupSearch();
});
